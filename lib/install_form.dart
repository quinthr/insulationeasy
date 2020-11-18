import 'dart:math';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import './models/InstallationFormEntry.dart';
import './models/FormImages.dart';
import './models/Hazards.dart';
import './models/SignatureForm.dart';
import './widget/checklist_form.dart';


class InstallForm extends StatefulWidget {
  @override
  _InstallFormState createState() => _InstallFormState();
}

Future<String> generateFormId() async {
  final prefs = await SharedPreferences.getInstance();
  //await prefs.clear();
  final checkId = prefs.getString('formId');
  final workername = prefs.getString('workerName');
  var rnd = new Random();
  var rnd2 = new Random();
  var next = rnd.nextDouble() * 1000000;
  var next2 = rnd2.nextDouble() * 1000000;
  while (next < 100000) {
    next *= 10;
  }
  while (next2 < 100000) {
    next2 *= 10;
  }
  var ordernumber = next.toInt().toString()+"-"+next2.toInt().toString();
  if (checkId == null) {
    var uuid = Uuid();
    String checkId = uuid.v4();
    prefs.setString("formId", checkId).then((bool success) {
      InstallationFormEntryDB.insert('installation_form_entry', {
        'formId': checkId,
        'orderNumber': ordernumber,
        'builderName': null,
        'address': null,
        'comments': null,
        'workSiteEvaluator': null,
        'workSiteEvaluatedDate': null,
        'builderConfirmation': null,
        'builderConfirmationDate': null,
        'assessorName': null,
        'status': 'On Progress',
        'workerName': workername,
      });
      for(var i=0; i<10; i++){
        FormImagesDB.insert('installation_form_images', {
          'imageData': null,
          'imageName': checkId+'-'+i.toString(),
          'indexnum': i,
          'formId': checkId,
          'status': 'Ongoing'
        });
      }
      for(var j=1; j<6; j++){
        HazardsDB.insert('installation_form_hazards', {
          'hazardId': checkId+'-hazard'+j.toString(),
          'hazardName': 'hazard'+j.toString(),
          'probability': 'Not applicable',
          'consequence': 'Not applicable',
          'risk': 'Not applicable',
          'controlMeasure': '',
          'person': '',
          'status': 'Ongoing',
          'formId': checkId
        });
      }
      SignatureFormDB.insert('installation_form_signatures', {
        'signatureName': checkId+'-WorkEvaluatorSignature',
        'signaturePoints': null,
        'signatureImage': null,
        'formId': checkId
      });
      SignatureFormDB.insert('installation_form_signatures', {
        'signatureName': checkId+'-BuilderSignature',
        'signaturePoints': null,
        'signatureImage': null,
        'formId': checkId
      });
    });
    print(checkId);
    return checkId;
  }
  else {
    print(checkId);
    return checkId;
  }
}

Future<dynamic> fetchFormData() async{
  var checknum = await generateFormId();
  print("FORMID CHECK:"+ checknum.toString());
  var dataList = await InstallationFormEntryDB.getOneFormData(checknum);
  print(dataList.toString());
  var formData = dataList.map(
        (item) => InstallationFormEntry(
      formId: item['formId'],
      builderName: item['builderName'],
      address: item['address'],
      orderNumber: item['orderNumber'],
      date: item['date'],
      comments: item['comments'],
      workSiteEvaluator: item['workSiteEvaluator'],
      workSiteEvaluatedDate: item['workSiteEvaluatedDate'],
      builderConfirmation: item['builderConfirmation'],
      builderConfirmationDate: item['builderConfirmationDate'],
      assessorName: item['assessorName'],
      status: item['status'],
      workerName: item['workerName'],
    ),
  ).toList();
  print(formData.toString());
  if (formData == null){
    return 0;
  }
  return formData;
}

String checkifEmpty(String text) {
  if (text == 'null'){
    text = '';
    return text;
  }
  else {
    return text;
  }
}

class _InstallFormState extends State<InstallForm> {
  final _form = GlobalKey<FormState>();
  DateTime selectedDate = DateTime.now();
  var dateController = TextEditingController();
  String _intFormId = '';
  String _intBuilderName = '';
  String _intOrderNumber = '';
  String _intAddress = '';
  String _intDate = '';
  String _intWorkerName = '';
  var _newForm = InstallationFormEntry(
    formId: '',
    builderName: '',
    orderNumber: '',
    address: '',
    date: '',
    comments: '',
    workSiteEvaluator: '',
    workSiteEvaluatedDate: '',
    builderConfirmation: '',
    builderConfirmationDate: '',
    assessorName: '',
    status: '',
    workerName: '',
  );
  @override
  void initState() {
    super.initState();
  }
  _InstallFormState() {
    fetchFormData().then((val) => setState(() {
      _newForm = InstallationFormEntry(
        formId: val[0].formId.toString(),
        builderName: checkifEmpty(val[0].builderName.toString()),
        orderNumber: checkifEmpty(val[0].orderNumber.toString()),
        address: checkifEmpty(val[0].address.toString()),
        date: checkifEmpty(val[0].date.toString()),
        comments: checkifEmpty(val[0].comments.toString()),
        workSiteEvaluator: checkifEmpty(val[0].workSiteEvaluator.toString()),
        workSiteEvaluatedDate: checkifEmpty(val[0].workSiteEvaluatedDate.toString()),
        builderConfirmation: checkifEmpty(val[0].builderConfirmation.toString()),
        builderConfirmationDate: checkifEmpty(val[0].builderConfirmationDate.toString()),
        assessorName: checkifEmpty(val[0].assessorName.toString()),
        status: checkifEmpty(val[0].status.toString()),
        workerName: val[0].workerName.toString(),
      );
      _intFormId = val[0].formId.toString();
      _intBuilderName = checkifEmpty(val[0].builderName.toString());
      _intOrderNumber = checkifEmpty(val[0].orderNumber.toString());
      _intAddress = checkifEmpty(val[0].address.toString());
      _intDate = checkifEmpty(val[0].date.toString());
      _intWorkerName = val[0].workerName.toString();
      dateController.text = _intDate;
      selectedDate = DateTime.parse(_intDate);
      print(_intBuilderName);
    }));
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2020),
        lastDate: DateTime.now());
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        dateController.text = "${selectedDate}".split(' ')[0];
        _intBuilderName = _newForm.builderName;
        _intOrderNumber = _newForm.orderNumber;
        _intAddress = _newForm.address;
        _newForm = InstallationFormEntry(
          formId: _intFormId,
          builderName: _newForm.builderName,
          orderNumber: _newForm.orderNumber,
          address: _newForm.address,
          date: "${selectedDate}".split(' ')[0],
          comments: _newForm.comments,
          workSiteEvaluator: _newForm.workSiteEvaluator,
          workSiteEvaluatedDate: _newForm.workSiteEvaluatedDate,
          builderConfirmation: _newForm.builderConfirmation,
          builderConfirmationDate:
          _newForm.builderConfirmationDate,
          assessorName: _newForm.assessorName,
          status: _newForm.status,
          workerName: _intWorkerName,
        );
        InstallationFormEntryDB.update(_intFormId, _newForm);
      });
    }
  }

  void _saveForm() {
    _form.currentState.save();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title:
          Text("Installation Form", style: TextStyle(color: Colors.white)),
          actions: <Widget>[
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(right: 5),
              child: Text("1/4",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold)),
            )
          ],
        ),
        body: FutureBuilder(
            future: fetchFormData(),
            builder: (ctx, snapshot) => snapshot.connectionState == ConnectionState.waiting
                ? Center(
              child: CircularProgressIndicator(),
            )
                : Padding(
              padding: const EdgeInsets.all(10.0),
              child: Form(
                key: _form,
                onChanged: _saveForm,
                child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Builder Name',
                            contentPadding: EdgeInsets.all(3),
                            border: OutlineInputBorder(),
                          ),
                          initialValue: _intBuilderName,
                          textInputAction: TextInputAction.next,
                          onChanged: (_) {
                            _saveForm();
                          },
                          onFieldSubmitted: (_) {
                            _saveForm();
                          },
                          validator: (value) {
                            if(value.isEmpty){
                              return 'Please enter the builder\'s name';
                            }
                            else{
                              return null;
                            }
                          },
                          onSaved: (value) {
                            _newForm = InstallationFormEntry(
                              formId: _intFormId,
                              builderName: value,
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
                              workerName: _intWorkerName,
                            );
                            InstallationFormEntryDB.update(_intFormId, _newForm);
                          },
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Address',
                            contentPadding: EdgeInsets.all(3),
                            border: OutlineInputBorder(),
                          ),
                          initialValue: _intAddress,
                          textInputAction: TextInputAction.next,
                          onChanged: (_) {
                            _saveForm();
                          },
                          onFieldSubmitted: (_) {
                            _saveForm();
                          },
                          validator: (value) {
                            if(value.isEmpty){
                              return 'Please enter the address';
                            }
                            else{
                              return null;
                            }
                          },
                          onSaved: (value) {
                            _newForm = InstallationFormEntry(
                              formId: _intFormId,
                              builderName: _newForm.builderName,
                              orderNumber: _newForm.orderNumber,
                              address: value,
                              date: _newForm.date,
                              comments: _newForm.comments,
                              workSiteEvaluator: _newForm.workSiteEvaluator,
                              workSiteEvaluatedDate: _newForm.workSiteEvaluatedDate,
                              builderConfirmation: _newForm.builderConfirmation,
                              builderConfirmationDate:
                              _newForm.builderConfirmationDate,
                              assessorName: _newForm.assessorName,
                              status: _newForm.status,
                              workerName: _intWorkerName,
                            );
                            InstallationFormEntryDB.update(_intFormId, _newForm);
                          },
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Order #',
                            contentPadding: EdgeInsets.all(3),
                            border: OutlineInputBorder(),
                          ),
                          initialValue: _intOrderNumber,
                          readOnly: true,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.number,
                          onChanged: (_) {
                            _saveForm();
                          },
                          onFieldSubmitted: (_) {
                            _saveForm();
                          },
                          onSaved: (value) {
                            _newForm = InstallationFormEntry(
                              formId: _intFormId,
                              builderName: _newForm.builderName,
                              orderNumber: value,
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
                              workerName: _intWorkerName,
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
                          controller: dateController,
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
                              formId: _intFormId,
                              builderName: _newForm.builderName,
                              orderNumber: _newForm.orderNumber,
                              address: _newForm.address,
                              date: value,
                              comments: _newForm.comments,
                              workSiteEvaluator: _newForm.workSiteEvaluator,
                              workSiteEvaluatedDate: _newForm.workSiteEvaluatedDate,
                              builderConfirmation: _newForm.builderConfirmation,
                              builderConfirmationDate:
                              _newForm.builderConfirmationDate,
                              assessorName: _newForm.assessorName,
                              status: _newForm.status,
                              workerName: _intWorkerName,
                            );
                            InstallationFormEntryDB.update(_intFormId, _newForm);
                          },
                        ),
                        FlatButton(
                          child: Text(
                            'Choose Date',
                          ),
                          onPressed: () => _selectDate(context),
                        ),
                        Container(
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            child: ElevatedButton(
                              onPressed: () {
                                final isValid = _form.currentState.validate();
                                if(!isValid){
                                  return;
                                }
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ChecklistForm()),
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
                                'Next',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
              ),
            )));
  }
}