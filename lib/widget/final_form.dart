import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:signature/signature.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mobile_app/models/Checklist.dart';
import 'package:mobile_app/models/FormImages.dart';
import 'package:mobile_app/models/Hazards.dart';
import '../install_form.dart';
import '../models/InstallationFormEntry.dart';
import '../models/SignatureForm.dart';
import '../install_form.dart';
import '../main.dart';
import '../login_form.dart';

class FinalSubmission extends StatefulWidget {
  @override
  _FinalSubmissionState createState() => _FinalSubmissionState();
}

Future<dynamic> fetchAndSetSignautreFormData(String signatureName) async{
  var _intFormId = await generateFormId();
  final dataList = await SignatureFormDB.getOneFormData(_intFormId, _intFormId+signatureName);

  var formData = dataList.map(
        (item) => SignatureForm(
      signatureName: item['signatureName'],
      signaturePoints: item['signaturePoints'],
      signatureImage: item['signatureImage'],
      formId: item['formId'],
    ),
  ).toList();
  print(formData);
  if (formData == null){
    return 0;
  }
  return formData;
}

Future<String> _removeFormId() async {
  final prefs = await SharedPreferences.getInstance();
  prefs.remove('formId');
  generateFormId();
}



class _FinalSubmissionState extends State<FinalSubmission> {
  final _form2 = GlobalKey<FormState>();
  FocusNode focusNodeBuilder;
  FocusNode focusNodeEvaluator;
  final GlobalKey<ScaffoldState> _finalformscaffold = new GlobalKey<ScaffoldState>();
  DateTime selectedDate2 = DateTime.now();
  DateTime selectedDate3 = DateTime.now();
  var dateController2 = TextEditingController();
  var dateController3 = TextEditingController();
  String _intFormId = '';
  String _intWorkSiteEvaluator = '';
  String _intBuilderConfirmation = '';
  String _intAssessorName = '';
  String _intDate2 = "${DateTime.now()}".split(' ')[0];
  String _intDate3 = "${DateTime.now()}".split(' ')[0];
  String _intUser = '';
  final snackBar = SnackBar(content: Text('Please enter your signature.'), duration: Duration(seconds: 2),);
  var _signatureController = SignatureController(
    penStrokeWidth: 5,
    penColor: Colors.black,
    exportBackgroundColor: Colors.white,
    points: null,
  );
  var _signatureController2 = SignatureController(
    penStrokeWidth: 5,
    penColor: Colors.black,
    exportBackgroundColor: Colors.white,
  );
  var _newForm = InstallationFormEntry(
    id: null,
    formId: '',
    builderName: '',
    orderNumber: '',
    address: '',
    date: null,
    comments: '',
    workSiteEvaluator: '',
    workSiteEvaluatedDate: "${DateTime.now()}".split(' ')[0],
    builderConfirmation: '',
    builderConfirmationDate: "${DateTime.now()}".split(' ')[0],
    assessorName: '',
    status: '',
    workerName: '',
  );
  var _newSignature = SignatureForm(
    signatureName: '',
    signaturePoints: null,
    signatureImage: null,
    formId: '',
  );
  var _newSignature2 = SignatureForm(
    signatureName: '',
    signaturePoints: null,
    signatureImage: null,
    formId: '',
  );
  void _saveSignature(SignatureController signatureController,String signatureName) async {
    if (signatureController.isNotEmpty) {
      var data = await signatureController.toPngBytes();
      var points = signatureController.points;
      var simplified =
      points.map((e) => [e.offset.dx, e.offset.dy, e.type.index]).toList();
      String encode = json.encode(simplified);
      _newSignature = SignatureForm(
        signatureName: _intFormId+'-'+signatureName,
        signaturePoints: encode,
        signatureImage: data,
        formId: _intFormId,
      );
      SignatureFormDB.update(_intFormId, _newSignature.signatureName, _newSignature);
    }
  }
  @override
  void initState() {
    super.initState();
    focusNodeBuilder = FocusNode();
    focusNodeEvaluator = FocusNode();
  }
  _FinalSubmissionState() {
    fetchFormData().then((val) => setState(() {
      _newForm = InstallationFormEntry(
        formId: val[0].formId.toString(),
        builderName: checkifEmpty(val[0].builderName.toString()),
        orderNumber: checkifEmpty(val[0].orderNumber.toString()),
        address: checkifEmpty(val[0].address.toString()),
        date: checkifEmpty(val[0].date.toString()),
        comments: checkifEmpty(val[0].comments.toString()),
        workSiteEvaluator:
        checkifEmpty(val[0].workSiteEvaluator.toString()),
        workSiteEvaluatedDate: "${DateTime.now()}".split(' ')[0],
        builderConfirmation:
        checkifEmpty(val[0].builderConfirmation.toString()),
        builderConfirmationDate: "${DateTime.now()}".split(' ')[0],
        assessorName: checkifEmpty(val[0].assessorName.toString()),
        status: checkifEmpty(val[0].status.toString()),
        workerName: val[0].workerName.toString(),
      );
      _intFormId = val[0].formId.toString();
      print(_intFormId);
      _intWorkSiteEvaluator =
          checkifEmpty(val[0].workSiteEvaluator.toString());
      _intBuilderConfirmation =
          checkifEmpty(val[0].builderConfirmation.toString());
      _intAssessorName = checkifEmpty(val[0].assessorName.toString());
      _intUser = val[0].workerName.toString();
      dateController2.text = _intDate2;
      dateController3.text = _intDate3;
      selectedDate2 = DateTime.parse(_intDate2);
      selectedDate3 = DateTime.parse(_intDate3);
    }));
    fetchAndSetSignautreFormData('-WorkEvaluatorSignature').then((val2) => setState(() {
      var decoded = json.decode(val2[0].signaturePoints) as List;
      var asPoints = decoded
          .map((e) => Point(Offset(e[0], e[1]), PointType.values[e[2]]))
          .toList();
      print('Points');
      print(asPoints);
      _signatureController.points=asPoints;
    }));
    fetchAndSetSignautreFormData('-BuilderSignature').then((val3) => setState(() {
      var decoded = json.decode(val3[0].signaturePoints) as List;
      var asPoints = decoded
          .map((e) => Point(Offset(e[0], e[1]), PointType.values[e[2]]))
          .toList();
      print('Points');
      print(asPoints);
      _signatureController2.points=asPoints;
    }));
  }
  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    focusNodeEvaluator.dispose();
    focusNodeBuilder.dispose();

    super.dispose();
  }

  void _saveForm() {
    _form2.currentState.save();
    _saveSignature(_signatureController, 'WorkEvaluatorSignature');
    _saveSignature(_signatureController2, 'BuilderSignature');
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
        key: _finalformscaffold,
        appBar: AppBar(
          title: Text("Submission", style: TextStyle(color: Colors.white)),
          actions: <Widget>[
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(right: 5),
              child: Text("6/6",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold)),
            )
          ],
        ),
        body: FutureBuilder(
            future: fetchFormData(),
            builder: (ctx, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
                ? Center(
              child: CircularProgressIndicator(),
            )
                : Padding(
                padding: const EdgeInsets.all(10.0),
                child: Form(
                    key: _form2,
                    onChanged: _saveForm,
                    child: SingleChildScrollView(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Column(children: [
                          SizedBox(
                            height: 20.0,
                          ),
                          TextFormField(
                            focusNode: focusNodeEvaluator,
                            decoration: InputDecoration(
                              labelText: 'Work site evaluated by',
                              contentPadding: EdgeInsets.all(3),
                              border: OutlineInputBorder(),
                              helperText: 'Please add your name',
                            ),
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.text,
                            onFieldSubmitted: (_) {
                              _saveForm();
                            },
                            onChanged: (_) {
                              _saveForm();
                            },
                            initialValue: _intWorkSiteEvaluator,
                            validator: (value) {
                              if(value.isEmpty){
                                return 'Please enter your name';
                              }
                              else{
                                return null;
                              }
                            },
                            onSaved: (value) {
                              _newForm = InstallationFormEntry(
                                id: _newForm.id,
                                formId: _newForm.formId,
                                builderName: _newForm.builderName,
                                orderNumber: _newForm.orderNumber,
                                address: _newForm.address,
                                date: _newForm.date,
                                comments: _newForm.comments,
                                workSiteEvaluator: value,
                                workSiteEvaluatedDate:
                                _newForm.workSiteEvaluatedDate,
                                builderConfirmation:
                                _newForm.builderConfirmation,
                                builderConfirmationDate:
                                _newForm.builderConfirmationDate,
                                assessorName: _newForm.assessorName,
                                status: _newForm.status,
                                workerName: _newForm.workerName,
                              );
                              InstallationFormEntryDB.update(_intFormId, _newForm);
                            },
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Date',
                              contentPadding: EdgeInsets.all(3),
                              border: OutlineInputBorder(),
                            ),
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.datetime,
                            controller: dateController2,
                            readOnly: true,
                            onChanged: (_) {
                              _saveForm();
                            },
                            validator: (value) {
                              if(value.isEmpty){
                                return 'Please select the date';
                              }
                              else{
                                return null;
                              }
                            },
                            onSaved: (value) {
                              _newForm = InstallationFormEntry(
                                id: _newForm.id,
                                formId: _newForm.formId,
                                builderName: _newForm.builderName,
                                orderNumber: _newForm.orderNumber,
                                address: _newForm.address,
                                date: _newForm.date,
                                comments: _newForm.comments,
                                workSiteEvaluator:
                                _newForm.workSiteEvaluator,
                                workSiteEvaluatedDate: value,
                                builderConfirmation:
                                _newForm.builderConfirmation,
                                builderConfirmationDate:
                                _newForm.builderConfirmationDate,
                                assessorName: _newForm.assessorName,
                                status: _newForm.status,
                                workerName: _newForm.workerName,
                              );
                            },
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Text(
                            'Signature',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          new GestureDetector(
                              onLongPress: () {
                                focusNodeEvaluator.unfocus();
                                focusNodeBuilder.unfocus();
                              },
                              onHorizontalDragStart: (_) {
                                focusNodeEvaluator.unfocus();
                                focusNodeBuilder.unfocus();
                              },
                              onVerticalDragDown: (_) {
                                focusNodeEvaluator.unfocus();
                                focusNodeBuilder.unfocus();
                              },
                              onVerticalDragStart: (_) {
                                focusNodeEvaluator.unfocus();
                                focusNodeBuilder.unfocus();
                              },
                              onTap: () {
                                focusNodeEvaluator.unfocus();
                                focusNodeBuilder.unfocus();
                              },
                              child: new Container(
                                child: Signature(
                                  controller: _signatureController,
                                  height: 300,
                                  backgroundColor: Colors.white,
                                ),
                                //rest of your code write here
                              )
                          ),
                          //OK AND CLEAR BUTTONS
                          Container(
                            decoration: const BoxDecoration(color: Colors.orange),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                //SHOW EXPORTED IMAGE IN NEW ROUTE
                                FlatButton(
                                  onPressed: () async {
                                    focusNodeEvaluator.unfocus();
                                    focusNodeBuilder.unfocus();
                                    _saveSignature(_signatureController, 'WorkEvaluatorSignature');
                                  },
                                  child: Text(
                                    'Save',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                FlatButton(
                                  onPressed: () {
                                    focusNodeEvaluator.unfocus();
                                    focusNodeBuilder.unfocus();
                                    _newSignature = SignatureForm(
                                      signatureName: _intFormId+'-WorkEvaluatorSignature',
                                      signaturePoints: null,
                                      signatureImage: null,
                                      formId: _intFormId,
                                    );
                                    SignatureFormDB.update(_intFormId, _newSignature.signatureName, _newSignature);
                                    setState(() {
                                      _intWorkSiteEvaluator = _newForm.workSiteEvaluator;
                                      _intBuilderConfirmation = _newForm.builderConfirmation;
                                      _intAssessorName = _newForm.assessorName;
                                      _intDate2 = _newForm.workSiteEvaluatedDate;
                                      _intDate3 = _newForm.builderConfirmationDate;
                                      _newForm = InstallationFormEntry(
                                        formId: _intFormId,
                                        builderName: _newForm.builderName,
                                        orderNumber: _newForm.orderNumber,
                                        address: _newForm.address,
                                        date: _newForm.date,
                                        comments: _newForm.comments,
                                        workSiteEvaluator: _newForm.workSiteEvaluator,
                                        workSiteEvaluatedDate: _newForm.workSiteEvaluatedDate,
                                        builderConfirmation: _newForm.builderConfirmation,
                                        builderConfirmationDate:
                                        _newForm.builderConfirmationDate,
                                        assessorName: _newForm.assessorName,
                                        status: _newForm.status,
                                        workerName: _newForm.workerName,
                                      );
                                      _signatureController.clear();
                                    });
                                  },
                                  child: Text(
                                    'Clear',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          const Divider(
                            height: 20,
                            thickness: 5,
                            indent: 0,
                            endIndent: 0,
                            color: Colors.black12,
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          TextFormField(
                            focusNode: focusNodeBuilder,
                            decoration: InputDecoration(
                              labelText: 'Builder\'s Confirmation',
                              contentPadding: EdgeInsets.all(3),
                              border: OutlineInputBorder(),
                              helperText:
                              'Please input builder or site supervisor\'s name',
                            ),
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.text,
                            onChanged: (_) {
                              _saveForm();
                            },
                            initialValue: _intBuilderConfirmation,
                            validator: (value) {
                              if(value.isEmpty){
                                return 'Please enter the builder or site supervisor\'s name';
                              }
                              else{
                                return null;
                              }
                            },
                            onSaved: (value) {
                              _newForm = InstallationFormEntry(
                                id: _newForm.id,
                                formId: _newForm.formId,
                                builderName: _newForm.builderName,
                                orderNumber: _newForm.orderNumber,
                                address: _newForm.address,
                                date: _newForm.date,
                                comments: _newForm.comments,
                                workSiteEvaluator:
                                _newForm.workSiteEvaluator,
                                workSiteEvaluatedDate:
                                _newForm.workSiteEvaluatedDate,
                                builderConfirmation: value,
                                builderConfirmationDate:
                                _newForm.builderConfirmationDate,
                                assessorName: _newForm.assessorName,
                                status: _newForm.status,
                                workerName: _newForm.workerName,
                              );
                              InstallationFormEntryDB.update(_intFormId, _newForm);
                            },
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Date',
                              contentPadding: EdgeInsets.all(3),
                              border: OutlineInputBorder(),
                            ),
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.datetime,
                            controller: dateController3,
                            readOnly: true,
                            onChanged: (_) {
                              _saveForm();
                            },
                            validator: (value) {
                              if(value.isEmpty){
                                return 'Please select the date';
                              }
                              else{
                                return null;
                              }
                            },
                            onSaved: (value) {
                              _newForm = InstallationFormEntry(
                                id: _newForm.id,
                                formId: _newForm.formId,
                                builderName: _newForm.builderName,
                                orderNumber: _newForm.orderNumber,
                                address: _newForm.address,
                                date: _newForm.date,
                                comments: _newForm.comments,
                                workSiteEvaluator:
                                _newForm.workSiteEvaluator,
                                workSiteEvaluatedDate:
                                _newForm.workSiteEvaluatedDate,
                                builderConfirmation:
                                _newForm.builderConfirmation,
                                builderConfirmationDate: value,
                                assessorName: _newForm.assessorName,
                                status: _newForm.status,
                                workerName: _newForm.workerName,
                              );
                            },
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Text(
                            'Signature',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          new GestureDetector(
                              onLongPress: () {
                                focusNodeEvaluator.unfocus();
                                focusNodeBuilder.unfocus();
                              },
                              onHorizontalDragStart: (_) {
                                focusNodeEvaluator.unfocus();
                                focusNodeBuilder.unfocus();
                              },
                              onVerticalDragDown: (_) {
                                focusNodeEvaluator.unfocus();
                                focusNodeBuilder.unfocus();
                              },
                              onVerticalDragStart: (_) {
                                focusNodeEvaluator.unfocus();
                                focusNodeBuilder.unfocus();
                              },
                              onTap: () {
                                focusNodeEvaluator.unfocus();
                                focusNodeBuilder.unfocus();
                              },
                              child: new Container(
                                child: Signature(
                                  controller: _signatureController2,
                                  height: 300,
                                  backgroundColor: Colors.white,
                                ),
                                //rest of your code write here
                              )
                          ),
                          //OK AND CLEAR BUTTONS
                          Container(
                            decoration: const BoxDecoration(color: Colors.orange),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                FlatButton(
                                  onPressed: () async {
                                    focusNodeEvaluator.unfocus();
                                    focusNodeBuilder.unfocus();
                                    _saveSignature(_signatureController2, 'BuilderSignature');
                                  },
                                  child: Text(
                                    'Save',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                FlatButton(
                                  onPressed: () {
                                    focusNodeEvaluator.unfocus();
                                    focusNodeBuilder.unfocus();
                                    _newSignature2 = SignatureForm(
                                      signatureName: _intFormId+'-BuilderSignature',
                                      signaturePoints: null,
                                      signatureImage: null,
                                      formId: _intFormId,
                                    );
                                    SignatureFormDB.update(_intFormId, _newSignature2.signatureName, _newSignature2);
                                    setState(() {
                                      _intWorkSiteEvaluator = _newForm.workSiteEvaluator;
                                      _intBuilderConfirmation = _newForm.builderConfirmation;
                                      _intAssessorName = _newForm.assessorName;
                                      _intDate2 = _newForm.workSiteEvaluatedDate;
                                      _intDate3 = _newForm.builderConfirmationDate;
                                      _newForm = InstallationFormEntry(
                                        formId: _intFormId,
                                        builderName: _newForm.builderName,
                                        orderNumber: _newForm.orderNumber,
                                        address: _newForm.address,
                                        date: _newForm.date,
                                        comments: _newForm.comments,
                                        workSiteEvaluator: _newForm.workSiteEvaluator,
                                        workSiteEvaluatedDate: _newForm.workSiteEvaluatedDate,
                                        builderConfirmation: _newForm.builderConfirmation,
                                        builderConfirmationDate:
                                        _newForm.builderConfirmationDate,
                                        assessorName: _newForm.assessorName,
                                        status: _newForm.status,
                                        workerName: _newForm.workerName,
                                      );
                                      _signatureController2.clear();
                                    });
                                  },
                                  child: Text(
                                    'Clear',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Container(
                            width: double.infinity,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 16.0),
                              child: ElevatedButton(
                                onPressed: () {
                                  focusNodeEvaluator.unfocus();
                                  focusNodeBuilder.unfocus();
                                  _saveForm();
                                  final isSigned = _signatureController.isNotEmpty;
                                  final isSigned2 = _signatureController2.isNotEmpty;
                                  if(!isSigned || !isSigned2){
                                    _finalformscaffold.currentState.showSnackBar(snackBar);
                                  }
                                  final isValid = _form2.currentState.validate();
                                  if(!isValid){
                                    return;
                                  }
                                  InstallationFormEntryDB.SetDone(_intFormId);
                                  HazardsDB.SetDone(_intFormId);
                                  FormImagesDB.SetDone(_intFormId);
                                  ChecklistDB.SetDone(_intFormId);
                                  _removeFormId();
                                  //Navigator.popUntil(context, ModalRoute.withName("dashboard"));
                                  //Navigator.pushReplacement(context, MaterialPageRoute(settings: RouteSettings(name: "dashboard"), builder: (BuildContext context) => MyHomePage()));
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(builder: (context) => AuthScreen()),
                                        (Route<dynamic> route) => false,
                                  );

                                  // Validate returns true if the form is valid, or false
                                  // otherwise.
                                  //if (_formKey.currentState.validate()) {
                                  // If the form is valid, display a Snackbar.
                                  //  Scaffold.of(context)
                                  //      .showSnackBar(SnackBar(content: Text('Processing Data')));
                                  //}
                                },
                                child: Text(
                                  'Submit',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ])
                    )
                )
            )
        )
    );
  }
}