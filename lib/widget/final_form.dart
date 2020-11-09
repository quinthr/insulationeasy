import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:signature/signature.dart';

import '../models/InstallationFormEntry.dart';
import '../install_form.dart';

class FinalSubmission extends StatefulWidget {
  @override
  _FinalSubmissionState createState() => _FinalSubmissionState();
}

class _FinalSubmissionState extends State<FinalSubmission> {
  final _form2 = GlobalKey<FormState>();
  DateTime selectedDate2 = DateTime.now();
  DateTime selectedDate3 = DateTime.now();
  var dateController2 = TextEditingController();
  var dateController3 = TextEditingController();
  String _intFormId = '';
  String _intWorkSiteEvaluator = '';
  String _intBuilderConfirmation = '';
  String _intAssessorName = '';
  String _intDate2 = '';
  String _intDate3 = '';
  final SignatureController _signatureController = SignatureController(
    penStrokeWidth: 5,
    penColor: Colors.black,
    exportBackgroundColor: Colors.white,
  );
  final SignatureController _signatureController2 = SignatureController(
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
    workSiteEvaluatedDate: null,
    builderConfirmation: '',
    builderConfirmationDate: null,
    assessorName: '',
    status: '',
  );

  _FinalSubmissionState() {
    fetchAndSetFormData().then((val) => setState(() {
          _newForm = InstallationFormEntry(
            formId: val[0].formId.toString(),
            builderName: checkifEmpty(val[0].builderName.toString()),
            orderNumber: checkifEmpty(val[0].orderNumber.toString()),
            address: checkifEmpty(val[0].address.toString()),
            date: checkifEmpty(val[0].date.toString()),
            comments: checkifEmpty(val[0].comments.toString()),
            workSiteEvaluator:
                checkifEmpty(val[0].workSiteEvaluator.toString()),
            workSiteEvaluatedDate:
                checkifEmpty(val[0].workSiteEvaluatedDate.toString()),
            builderConfirmation:
                checkifEmpty(val[0].builderConfirmation.toString()),
            builderConfirmationDate:
                checkifEmpty(val[0].builderConfirmationDate.toString()),
            assessorName: checkifEmpty(val[0].assessorName.toString()),
            status: checkifEmpty(val[0].status.toString()),
          );
          _intFormId = val[0].formId.toString();
          _intWorkSiteEvaluator =
              checkifEmpty(val[0].workSiteEvaluator.toString());
          _intBuilderConfirmation =
              checkifEmpty(val[0].builderConfirmation.toString());
          _intAssessorName = checkifEmpty(val[0].assessorName.toString());
          _intDate2 = checkifEmpty(val[0].workSiteEvaluatedDate.toString());
          _intDate3 = checkifEmpty(val[0].builderConfirmationDate.toString());
          dateController2.text = _intDate2;
          dateController3.text = _intDate3;
          selectedDate2 = DateTime.parse(_intDate2);
          selectedDate3 = DateTime.parse(_intDate3);
        }));
  }

  Future<void> _selectDate2(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate2,
        firstDate: DateTime(2020),
        lastDate: DateTime.now());
    if (picked != null && picked != selectedDate2)
      setState(() {
        selectedDate2 = picked;
        dateController2.text = "${selectedDate2}".split(' ')[0];
        _intWorkSiteEvaluator = _newForm.workSiteEvaluator;
        _intBuilderConfirmation = _newForm.builderConfirmation;
        _intAssessorName = _newForm.assessorName;
        _newForm = InstallationFormEntry(
          formId: _intFormId,
          builderName: _newForm.builderName,
          orderNumber: _newForm.orderNumber,
          address: _newForm.address,
          date: _newForm.date,
          comments: _newForm.comments,
          workSiteEvaluator: _newForm.workSiteEvaluator,
          workSiteEvaluatedDate: "${selectedDate2}".split(' ')[0],
          builderConfirmation: _newForm.builderConfirmation,
          builderConfirmationDate: _newForm.builderConfirmationDate,
          assessorName: _newForm.assessorName,
          status: _newForm.status,
        );
        InstallationFormEntryDB.update(_intFormId, _newForm);
      });
  }

  Future<void> _selectDate3(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate3,
        firstDate: DateTime(2020),
        lastDate: DateTime.now());
    if (picked != null && picked != selectedDate3)
      setState(() {
        selectedDate3 = picked;
        dateController3.text = "${selectedDate3}".split(' ')[0];
        _intWorkSiteEvaluator = _newForm.workSiteEvaluator;
        _intBuilderConfirmation = _newForm.builderConfirmation;
        _intAssessorName = _newForm.assessorName;
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
          builderConfirmationDate: "${selectedDate3}".split(' ')[0],
          assessorName: _newForm.assessorName,
          status: _newForm.status,
        );
        InstallationFormEntryDB.update(_intFormId, _newForm);
      });
  }

  void _saveForm() {
    _form2.currentState.save();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Submission", style: TextStyle(color: Colors.white)),
          actions: <Widget>[
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(right: 5),
              child: Text("4/4",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold)),
            )
          ],
        ),
        body: FutureBuilder(
            future: fetchAndSetFormData(),
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
                                  );
                                },
                              ),
                              FlatButton(
                                child: Text(
                                  'Choose Date',
                                ),
                                onPressed: () => _selectDate2(context),
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
                              Signature(
                                controller: _signatureController,
                                height: 300,
                                backgroundColor: Colors.white,
                              ),
                              //OK AND CLEAR BUTTONS
                              Container(
                                decoration: const BoxDecoration(color: Colors.orange),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    //SHOW EXPORTED IMAGE IN NEW ROUTE
                                    IconButton(
                                      icon: const Icon(Icons.check),
                                      color: Colors.white,
                                      onPressed: () async {
                                        if (_signatureController.isNotEmpty) {
                                          var data = await _signatureController.toPngBytes();
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (BuildContext context) {
                                                return Scaffold(
                                                  appBar: AppBar(),
                                                  body: Center(
                                                      child: Container(
                                                          color: Colors.grey[300], child: Image.memory(data))),
                                                );
                                              },
                                            ),
                                          );
                                        }
                                      },
                                    ),
                                    //CLEAR CANVAS
                                    IconButton(
                                      icon: const Icon(Icons.clear),
                                      color: Colors.white,
                                      onPressed: () {
                                        setState(() => _signatureController.clear());
                                      },
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
                                  );
                                },
                              ),
                              FlatButton(
                                child: Text(
                                  'Choose Date',
                                ),
                                onPressed: () => _selectDate3(context),
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
                              Signature(
                                controller: _signatureController2,
                                height: 300,
                                backgroundColor: Colors.white,
                              ),
                              //OK AND CLEAR BUTTONS
                              Container(
                                decoration: const BoxDecoration(color: Colors.orange),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    //SHOW EXPORTED IMAGE IN NEW ROUTE
                                    IconButton(
                                      icon: const Icon(Icons.check),
                                      color: Colors.white,
                                      onPressed: () async {
                                        if (_signatureController2.isNotEmpty) {
                                          var data = await _signatureController2.toPngBytes();
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (BuildContext context) {
                                                return Scaffold(
                                                  appBar: AppBar(),
                                                  body: Center(
                                                      child: Container(
                                                          color: Colors.grey[300], child: Image.memory(data))),
                                                );
                                              },
                                            ),
                                          );
                                        }
                                      },
                                    ),
                                    //CLEAR CANVAS
                                    IconButton(
                                      icon: const Icon(Icons.clear),
                                      color: Colors.white,
                                      onPressed: () {
                                        setState(() => _signatureController2.clear());
                                      },
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
                                decoration: InputDecoration(
                                  labelText: 'Assessor\'s Name',
                                  contentPadding: EdgeInsets.all(3),
                                  border: OutlineInputBorder(),
                                ),
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.text,
                                onChanged: (_) {
                                  _saveForm();
                                },
                                initialValue: _intAssessorName,
                                validator: (value) {
                                  if(value.isEmpty){
                                    return 'Please enter the assessor\'s name';
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
                                    builderConfirmationDate:
                                        _newForm.builderConfirmationDate,
                                    assessorName: value,
                                    status: _newForm.status,
                                  );
                                  InstallationFormEntryDB.update(_intFormId, _newForm);
                                },
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              SizedBox(
                                height: 20.0,
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
                                      final isValid = _form2.currentState.validate();
                                      if(!isValid){
                                        return;
                                      }
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
