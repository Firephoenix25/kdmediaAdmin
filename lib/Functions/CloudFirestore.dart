import 'package:cloud_firestore/cloud_firestore.dart';
import 'Extensions.dart';

Future<List<Map<String, dynamic>?>> getProgress() async {
  List<Map<String, dynamic>?> list = [];

  FirebaseFirestore leads = FirebaseFirestore.instance;

  QuerySnapshot data =
      await leads.collection("Progress  kayodionizio").orderBy('time').get();

  data.docs.forEach((element) {
    list.add(element.data());
  });

  return list;
}

//Get Acutal Users
Future<List<Map<String, dynamic>?>> getAuthUsers() async {
  List<Map<String, dynamic>?> list = [];

  FirebaseFirestore leads = FirebaseFirestore.instance;

  QuerySnapshot data = await leads.collection('Auth').get();

  data.docs.forEach((element) {
    list.add(element.data());
  });

  return list;
}

Future<void> addLeads(List list, String user, int number) async {
  int i;
  int index = 0;
  CollectionReference leads =
      FirebaseFirestore.instance.collection('Leads ' + user);
  DocumentReference id =
      FirebaseFirestore.instance.collection('Auth').doc(user);

  //get actual ID
  id.get().then((value) => index = value.get("Leads"));
  //Insert Leads in Right Place
  for (i = 0; i < number; i++) {
    await leads.doc(list[i]['numbers']['number0']).get().then((doc) {
      if (doc.exists == false) {
        leads.doc(list[i]['numbers']['number0']).set({
          "id": index,
          "name": list[i]['name'],
          "website": list[i]['website'],
          "numbers": list[i]['numbers'],
          "email": list[i]['email'],
          "facebook": list[i]['facebook'],
          "instagram": list[i]['instagram'],
          "linkedin": list[i]['linkedin'],
          "youtube": list[i]['youtube'],
          "category": list[i]['category'],
          "query":
              list[i]['query'].toString().toQueryCities().replaceAll("+", " ")
        });
        id.update({"Leads": FieldValue.increment(1)});
        index++;
      } else {
        print("ahaah");
      }
    }).catchError((error) {
      if (error != null) print("Failed to add user: $error");
    });
  }
}

/*
Future<List<Map>> readClosedCall() async {
  List<Map> list = [];

  FirebaseFirestore leads = FirebaseFirestore.instance;

  QuerySnapshot data = await leads.collection('ClosedCall').orderBy('id').get();

  data.docs.forEach((element) => list.add(element.data()));

  return list;
}

Future<List<Map>> readToRecall() async {
  List<Map> list = [];

  FirebaseFirestore leads = FirebaseFirestore.instance;

  QuerySnapshot data = await leads.collection('ToRecall').orderBy('date').get();

  data.docs.forEach((element) => list.add(element.data()));

  return list;
}

Future<List<Map>> readNotAnswered() async {
  List<Map> list = [];

  FirebaseFirestore leads = FirebaseFirestore.instance;

  QuerySnapshot data =
      await leads.collection('NotAnswered').orderBy('id').get();

  data.docs.forEach((element) => list.add(element.data()));

  return list;
}

Future<List<Map>> readRecallMeeting() async {
  List<Map> list = [];

  FirebaseFirestore leads = FirebaseFirestore.instance;

  QuerySnapshot data =
      await leads.collection('RecallMeeting').orderBy('id').get();

  data.docs.forEach((element) => list.add(element.data()));

  return list;
}

Future<List<Map>> readMeeting() async {
  List<Map> list = [];

  FirebaseFirestore leads = FirebaseFirestore.instance;

  QuerySnapshot data = await leads.collection('Meeting').orderBy('id').get();

  data.docs.forEach((element) => list.add(element.data()));

  return list;
}

Future<List<Map>> allLeads() async {
  List<Map> list = [];

  FirebaseFirestore leads = FirebaseFirestore.instance;

  DocumentSnapshot output = await leads.collection('ID').doc('output').get();

  QuerySnapshot data = await leads.collection('ClosedCall').get();
  QuerySnapshot data2 = await leads.collection('NotAnswered').get();
  QuerySnapshot data3 = await leads.collection('ToRecall').get();
  QuerySnapshot data4 = await leads.collection('RecallMeeting').get();
  QuerySnapshot data5 = await leads.collection('Meeting').get();

  data.docs.forEach((element) {
    Map a = element.data();
    a["esito"] = "ClosedCall";

    list.add(a);
  });
  data2.docs.forEach((element) {
    Map a = element.data();
    a["esito"] = "NotAnswered";

    list.add(a);
  });
  data3.docs.forEach((element) {
    Map a = element.data();
    a["esito"] = "ToRecall";

    list.add(a);
  });
  data4.docs.forEach((element) {
    Map a = element.data();
    a["esito"] = "RecallMeeting";

    list.add(a);
  });
  data5.docs.forEach((element) {
    Map a = element.data();
    a["esito"] = "Meeting";

    list.add(a);
  });

  list.sort((a, b) => a['id'] > b['id'] ? 1 : -1);
  list.removeWhere((element) => element['id'] < output.data()['id']);

  return list;
}
 */
