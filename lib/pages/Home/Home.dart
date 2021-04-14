import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:leadsadmin/pages/Tables/LeadsInsert.dart';
import '../Progress.dart';
import 'dart:convert';

class Home extends StatelessWidget {
  void pick() async {
    try {
// Will let you pick one file path, from all extensions
      FilePickerResult? result =
          await FilePicker.platform.pickFiles(type: FileType.any);

      if (result != null) {
        PlatformFile? file = result.files.first;
        List list = jsonDecode(String.fromCharCodes(file.bytes!));
        list.forEach((element) {
          print(element['name']);
        });
        Get.to(LeadsInsertTable(leads: list));
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("LeadAdmin App"),
        ),
        body: Center(
          child: Column(
            children: [
              Container(
                  width: 500,
                  height: 500,
                  child: Image(image: AssetImage('logo.png'))),
              ElevatedButton(onPressed: pick, child: Text("AddLeads")),
              ElevatedButton(
                  onPressed: () => Get.to(UserProgress()),
                  child: Text("Tracking")),
            ],
          ),
        ));
  }
}
