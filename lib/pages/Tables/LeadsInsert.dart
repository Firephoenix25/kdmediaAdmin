import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../Functions/CloudFirestore.dart';

class LeadsInsertTable extends StatelessWidget {
  LeadsInsertTable({required this.leads});
  final List leads;
  final BoxDecoration decoration = BoxDecoration(
    border: Border.all(
      color: Colors.black,
      width: 1,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => Get.dialog(DialogAuth(leads: leads)),
      ),
      appBar: AppBar(
        title: Text(
          leads.length.toString() + " Leads Finded",
        ),
      ),
      body: Column(
        children: [
          Expanded(
              child: ListView.builder(
                  itemCount: leads.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Row(
                      children: [
                        Expanded(
                          flex: 4,
                          child: Container(
                            decoration: decoration,
                            child: Text(leads[index]['name']),
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: Container(
                            decoration: decoration,
                            child: Text(leads[index]['category']),
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: Container(
                            decoration: decoration,
                            child: Text(leads[index]['website']),
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: Container(
                            decoration: decoration,
                            child: Text(leads[index]['query']
                                .toString()
                                .toQueryCities()
                                .replaceAll("+", " ")),
                          ),
                        ),
                      ],
                    );
                  }))
        ],
      ),
    );
  }
}

extension What on String {
  String toCities() {
    String s = this;
    List list = s.split(",");
    print(s);

    s = list[2].toString().replaceAll(" ", "");
    if (s.length > 8) s = s.substring(5, s.length - 2);
    return s;
  }

  String toQueryCities() {
    String s = this;
    List list = s.split("/");
    print(s);

    s = list[list.length - 1];
    String len = list[list.length - 1].split("+")[0].length.toString();
    s = s.substring(int.parse(len) + 1);
    return s;
  }
}

class DialogAuth extends StatefulWidget {
  DialogAuth({required this.leads});
  List leads;
  @override
  _DialogAuthState createState() => _DialogAuthState();
}

class _DialogAuthState extends State<DialogAuth> {
  final Future<List<Map<String, dynamic>?>> future = getAuthUsers();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: FutureBuilder<List<Map<String, dynamic>?>>(
            future: future,
            builder: (BuildContext context,
                AsyncSnapshot<List<Map<String, dynamic>?>> snap) {
              if (snap.hasData) {
                return Center(
                  child: DialogMenu(snap: snap, leads: widget.leads),
                );
              } else
                return CircularProgressIndicator();
            }),
      ),
    );
  }
}

class DialogMenu extends StatefulWidget {
  DialogMenu({required this.snap, required this.leads});
  final AsyncSnapshot<List<Map<String, dynamic>?>> snap;
  final List leads;
  @override
  _DialogMenuState createState() => _DialogMenuState();
}

class _DialogMenuState extends State<DialogMenu> {
  late String dropdownValue;
  List<Map<String, dynamic>?> list = [];
  List<String> menu = [];
  String input = "";
  @override
  void initState() {
    if (widget.snap.data != null) {
      list = widget.snap.data!;
      list.forEach((element) {
        if (element != null) menu.add(element['name']);
      });
    }
    dropdownValue = menu[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              color: Colors.white,
              child: DropdownButton<String>(
                value: dropdownValue,
                icon: Icon(Icons.arrow_downward),
                iconSize: 24,
                elevation: 16,
                style: TextStyle(color: Colors.blue),
                underline: Container(
                  height: 2,
                  color: Colors.blue,
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    if (newValue != null) dropdownValue = newValue;
                    print(dropdownValue);
                  });
                },
                items: menu.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
            Container(
              color: Colors.white,
              height: 50,
              width: 300,
              child: TextField(
                onChanged: (value) {
                  input = value;
                  print(input);
                },
                decoration: InputDecoration(labelText: "Enter your number"),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
            ),
            Container(
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.all(10),
                child: ElevatedButton(
                    onPressed: () async {
                      await addLeads(
                          widget.leads, dropdownValue, int.parse(input));
                      Get.back();
                    },
                    child: Text("Come on")),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
