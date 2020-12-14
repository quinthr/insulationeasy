import 'dart:convert';
import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile_app/models/Checklist.dart';
import 'package:mobile_app/models/FormImages.dart';
import 'package:mobile_app/models/Hazards.dart';
import 'package:mobile_app/models/SignatureForm.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';



import './install_form.dart';
import './widget/entries_list.dart';
import './login_form.dart';
import './models/entries.dart';
import './models/PopUpMenuList.dart';
import './models/InstallationFormEntry.dart';

void main() {
  runApp(MyApp());
}

Future<String> _removeUser() async {
  final prefs = await SharedPreferences.getInstance();
  prefs.remove('workerName');
}

Future<String> uploadChecklist(String formId) async {
  var dataList = await ChecklistDB.getAll(formId);
  const url = 'http://10.0.2.2:8270/api/checklist/upload';
  for(var i=0; i<dataList.length; i++){
    var checklist = json.encode({
      'text': dataList[i]['text'],
      'status':'Done',
      'formId': formId,
    });
    http.post(url, body: checklist, headers: {
      "Content-Type": "application/json"});
    ChecklistDB.SetUploaded(dataList[i]['formId']);
  }
}

Future<String> uploadImage(String formId) async {
  var dataList = await FormImagesDB.getAll(formId);
  const url = 'http://10.0.2.2:8270/api/image/upload';
  for(var i=0; i<dataList.length; i++){
    var encodeItem;
    if(dataList[i]['imageData'].toString() == 'null'){
      encodeItem = null;
    }
    else {
      final tempDir = await getTemporaryDirectory();
      final file = await new File('${tempDir.path}/'+dataList[i]['imageName']).create();
      file.writeAsBytesSync(dataList[i]['imageData']);
      encodeItem = base64Encode(file.readAsBytesSync());
    }
    var image = json.encode({
      'imageName': dataList[i]['imageName'],
      'imageData': encodeItem,
      'indexnum': dataList[i]['indexnum'],
      'status':'Done',
      'formId': dataList[i]['formId'],
    });
    http.post(url, body: image, headers: {
      "Content-Type": "application/json"});
    FormImagesDB.SetUploaded(dataList[i]['formId']);
  }
}

Future<String> uploadHazards(String formId) async {
  var dataList = await HazardsDB.getAll(formId);
  const url = 'http://10.0.2.2:8270/api/hazard/upload';
  for(var i=0; i<dataList.length; i++){
    var hazards = json.encode({
      'hazardName': dataList[i]['hazardName'],
      'probability': dataList[i]['probability'],
      'consequence': dataList[i]['consequence'],
      'risk': dataList[i]['risk'],
      'controlMeasure': dataList[i]['controlMeasure'],
      'person': dataList[i]['person'],
      'status':'Done',
      'formId': formId,
    });
    http.post(url, body: hazards, headers: {
      "Content-Type": "application/json"});
    HazardsDB.SetUploaded(dataList[i]['formId']);
  }
}

Future<String> uploadSignature(String formId) async {
  var dataList = await SignatureFormDB.getAll(formId);
  const url = 'http://10.0.2.2:8270/api/signature/upload';
  for(var i=0; i<dataList.length; i++){
    final tempDir = await getTemporaryDirectory();
    final file = await new File('${tempDir.path}/'+dataList[i]['signatureName']).create();
    file.writeAsBytesSync(dataList[i]['signatureImage']);
    var encodeItem = base64Encode(file.readAsBytesSync());
    var signatures = json.encode({
      'signatureName': dataList[i]['signatureName'],
      'signaturePoints': dataList[i]['signaturePoints'],
      'signatureImage': encodeItem,
      'formId': formId,
    });
    http.post(url, body: signatures, headers: {
      "Content-Type": "application/json"});
  }
}

Future<dynamic> uploadFormEntries() async{
  var dataList = await InstallationFormEntryDB.getUploadData('installation_form_entry');
  const url = 'http://10.0.2.2:8270/api/entry/upload';
  for(var i=0; i<dataList.length; i++){
    var entry = json.encode({
      'formId': dataList[i]['formId'],
      'orderNumber': dataList[i]['orderNumber'],
      'builderName':dataList[i]['builderName'],
      'address': dataList[i]['address'],
      'date': dataList[i]['date'],
      'comments': dataList[i]['comments'],
      'workSiteEvaluator': dataList[i]['workSiteEvaluator'],
      'workSiteEvaluatedDate': dataList[i]['workSiteEvaluatedDate'],
      'builderConfirmation': dataList[i]['builderConfirmation'],
      'builderConfirmationDate': dataList[i]['builderConfirmationDate'],
      'assessorName': dataList[i]['assessorName'],
      'status': dataList[i]['status'],
      'workerName': dataList[i]['workerName'],
    });
    http.post(url, body: entry, headers: {
    "Content-Type": "application/json"});
    InstallationFormEntryDB.SetUploaded(dataList[i]['formId']);
    uploadChecklist(dataList[i]['formId']);
    uploadImage(dataList[i]['formId']);
    uploadHazards(dataList[i]['formId']);
    uploadSignature(dataList[i]['formId']);
  }
  return 0;
}

Future<dynamic> updateFormEntries() async{
  var dataList = await InstallationFormEntryDB.getAllFormId();
  List<String> formIdList = new List();
  const url = 'http://10.0.2.2:8270/api/update/entries';
  print("DATALIST");
  print(dataList[0].formId);
  for(var i=0; i<dataList.length; i++){
    formIdList.add(dataList[i].formId);
  }
  var encoded = json.encode({
    'entries': formIdList
  });
  print('ENTRIES: '+ formIdList.toString());
  var response = await http.post(url, body: encoded, headers: {
    "Content-Type": "application/json"});
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    var newEntries = jsonDecode(response.body);
    for(var i=0; i<newEntries['entries'].length; i++){
      InstallationFormEntryDB.insert('installation_form_entry', {
        'formId': newEntries['entries'][i]['formId'],
        'orderNumber': newEntries['entries'][i]['orderNumber'],
        'builderName': newEntries['entries'][i]['builderName'],
        'address': newEntries['entries'][i]['address'],
        'date': newEntries['entries'][i]['date'],
        'comments': newEntries['entries'][i]['comments'],
        'workSiteEvaluator': newEntries['entries'][i]['workSiteEvaluator'],
        'workSiteEvaluatedDate': newEntries['entries'][i]['workSiteEvaluatedDate'],
        'builderConfirmation': newEntries['entries'][i]['builderConfirmation'],
        'builderConfirmationDate': newEntries['entries'][i]['builderConfirmationDate'],
        'assessorName': newEntries['entries'][i]['assessorName'],
        'status': newEntries['entries'][i]['status'],
        'workerName': newEntries['entries'][i]['workerName'],
      });
    }
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

void newAction(String choice, BuildContext context) {
  if (choice == PopUpMenuList.Logout) {
    _removeUser();
    Navigator.pushAndRemoveUntil(
        context,
        PageRouteBuilder(pageBuilder: (BuildContext context, Animation animation,
            Animation secondaryAnimation) {
          return AuthScreen();
        }, transitionsBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation, Widget child) {
          return new SlideTransition(
            position: new Tween<Offset>(
              begin: const Offset(1.0, 0.0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
        }),
            (Route route) => false);
  }
  if (choice == PopUpMenuList.Refresh) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => AuthScreen()),
          (Route<dynamic> route) => false,
    );
  }
}

class MyApp extends StatelessWidget {
  static const routeName = '/home';
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Insulation Easy Australia',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.orange,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: AuthScreen(),
    );
  }
}



class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  _MyHomePageState() {
    generateFormId();
    uploadFormEntries();
    updateFormEntries();
  }
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        // title: Text(widget.title, style: TextStyle(color: Colors.white)),
        title: Image.asset('assets/images/title.png', fit: BoxFit.cover, height: 38),
        actions: <Widget>[
          PopupMenuButton<String>(
            color: Colors.white,
            icon: Icon(Icons.more_horiz, color: Colors.white),
            onSelected: (val) => newAction(val, context),
            itemBuilder: (BuildContext context) {
              return PopUpMenuList.choices.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          )
        ],
      ),
      body: Column(
            // Column is also a layout widget. It takes a list of children and
            // arranges them vertically. By default, it sizes itself to fit its
            // children horizontally, and tries to be as tall as its parent.
            //
            // Invoke "debug painting" (press "p" in the console, choose the
            // "Toggle Debug Paint" action from the Flutter Inspector in Android
            // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
            // to see the wireframe for each widget.
            //
            // Column has various properties to control how it sizes itself and
            // how it positions its children. Here we use mainAxisAlignment to
            // center the children vertically; the main axis here is the vertical
            // axis because Columns are vertical (the cross axis would be
            // horizontal).
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 10, top: 10),
                child:
                  Text(
                    'Installation Form Entries',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18,),
                  ),
              ),
              EntryList(),
          ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => InstallForm()),
          );
        },
        child: Icon(Icons.add, color: Colors.white),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
