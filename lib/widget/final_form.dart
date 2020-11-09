import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_signature_pad/flutter_signature_pad.dart';

import '../models/InstallationFormEntry.dart';

class FinalSubmission extends StatefulWidget {
  @override
  _FinalSubmissionState createState() => _FinalSubmissionState();
}

class _WatermarkPaint extends CustomPainter {
  final String price;
  final String watermark;

  _WatermarkPaint(this.price, this.watermark);

  @override
  void paint(ui.Canvas canvas, ui.Size size) {}

  @override
  bool shouldRepaint(_WatermarkPaint oldDelegate) {
    return oldDelegate != this;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _WatermarkPaint &&
          runtimeType == other.runtimeType &&
          price == other.price &&
          watermark == other.watermark;

  @override
  int get hashCode => price.hashCode ^ watermark.hashCode;
}

class _FinalSubmissionState extends State<FinalSubmission> {
  DateTime selectedDate2 = DateTime.now();
  DateTime selectedDate3 = DateTime.now();
  var dateController2 = TextEditingController();
  var dateController3 = TextEditingController();
  var color = Colors.black;
  var strokeWidth = 5.0;
  final _sign = GlobalKey<SignatureState>();
  final _sign2 = GlobalKey<SignatureState>();
  ByteData _img = ByteData(0);
  ByteData _img2 = ByteData(0);
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
    workSiteEvaluatorSignature: '',
    builderConfirmation: '',
    builderConfirmationDate: null,
    builderConfirmationSignature: '',
    assessorName: '',
    status: '',
  );

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
      });
  }
  void _saveForm() {

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
        body: Container(
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
                    workSiteEvaluatedDate: _newForm.workSiteEvaluatedDate,
                    workSiteEvaluatorSignature:
                    _newForm.workSiteEvaluatorSignature,
                    builderConfirmation: _newForm.builderConfirmation,
                    builderConfirmationDate: _newForm.builderConfirmationDate,
                    builderConfirmationSignature:
                    _newForm.builderConfirmationSignature,
                    assessorName: _newForm.assessorName,
                    status: _newForm.status,
                  );
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
                onSaved: (value) {
                  _newForm = InstallationFormEntry(
                    id: _newForm.id,
                    formId: _newForm.formId,
                    builderName: _newForm.builderName,
                    orderNumber: _newForm.orderNumber,
                    address: _newForm.address,
                    date: _newForm.date,
                    comments: _newForm.comments,
                    workSiteEvaluator: _newForm.workSiteEvaluator,
                    workSiteEvaluatedDate: value,
                    workSiteEvaluatorSignature:
                    _newForm.workSiteEvaluatorSignature,
                    builderConfirmation: _newForm.builderConfirmation,
                    builderConfirmationDate: _newForm.builderConfirmationDate,
                    builderConfirmationSignature:
                    _newForm.builderConfirmationSignature,
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
              SizedBox(
                height: 175,
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Signature(
                      color: color,
                      key: _sign,
                      onSign: () {
                        final sign = _sign.currentState;
                        debugPrint(
                            '${sign.points.length} points in the signature');
                      },
                      backgroundPainter: _WatermarkPaint("2.0", "2.0"),
                      strokeWidth: strokeWidth,
                    ),
                  ),
                  color: Colors.black12,
                ),
              ),
              Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MaterialButton(
                          color: Colors.orange,
                          onPressed: () async {
                            final sign = _sign.currentState;
                            //retrieve image data, do whatever you want with it (send to server, save locally...)
                            final image = await sign.getData();
                            var data = await image.toByteData(
                                format: ui.ImageByteFormat.png);
                            _saveForm();
                            final encoded =
                            base64.encode(data.buffer.asUint8List());
                            _newForm = InstallationFormEntry(
                              id: _newForm.id,
                              formId: _newForm.formId,
                              builderName: _newForm.builderName,
                              orderNumber: _newForm.orderNumber,
                              address: _newForm.address,
                              date: _newForm.date,
                              comments: _newForm.comments,
                              workSiteEvaluator: _newForm.workSiteEvaluator,
                              workSiteEvaluatedDate:
                              _newForm.workSiteEvaluatedDate,
                              workSiteEvaluatorSignature: encoded,
                              builderConfirmation:
                              _newForm.builderConfirmation,
                              builderConfirmationDate:
                              _newForm.builderConfirmationDate,
                              builderConfirmationSignature:
                              _newForm.builderConfirmationSignature,
                              assessorName: _newForm.assessorName,
                              status: _newForm.status,
                            );
                            setState(() {
                              _img = data;
                            });
                            debugPrint("onPressed " + encoded);
                          },
                          child: Text(
                            "Save",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          )),
                      MaterialButton(
                          color: Colors.deepOrange,
                          onPressed: () {
                            final sign = _sign.currentState;
                            sign.clear();
                            _newForm = InstallationFormEntry(
                              id: _newForm.id,
                              formId: _newForm.formId,
                              builderName: _newForm.builderName,
                              orderNumber: _newForm.orderNumber,
                              address: _newForm.address,
                              date: _newForm.date,
                              comments: _newForm.comments,
                              workSiteEvaluator: _newForm.workSiteEvaluator,
                              workSiteEvaluatedDate:
                              _newForm.workSiteEvaluatedDate,
                              workSiteEvaluatorSignature: '',
                              builderConfirmation:
                              _newForm.builderConfirmation,
                              builderConfirmationDate:
                              _newForm.builderConfirmationDate,
                              builderConfirmationSignature:
                              _newForm.builderConfirmationSignature,
                              assessorName: _newForm.assessorName,
                              status: _newForm.status,
                            );
                            setState(() {
                              _img = ByteData(0);
                            });
                            debugPrint("cleared");
                          },
                          child: Text(
                            "Clear",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          )),
                    ],
                  ),
                ],
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
                onSaved: (value) {
                  _newForm = InstallationFormEntry(
                    id: _newForm.id,
                    formId: _newForm.formId,
                    builderName: _newForm.builderName,
                    orderNumber: _newForm.orderNumber,
                    address: _newForm.address,
                    date: _newForm.date,
                    comments: _newForm.comments,
                    workSiteEvaluator: _newForm.workSiteEvaluator,
                    workSiteEvaluatedDate: _newForm.workSiteEvaluatedDate,
                    workSiteEvaluatorSignature:
                    _newForm.workSiteEvaluatorSignature,
                    builderConfirmation: value,
                    builderConfirmationDate: _newForm.builderConfirmationDate,
                    builderConfirmationSignature:
                    _newForm.builderConfirmationSignature,
                    assessorName: _newForm.assessorName,
                    status: _newForm.status,
                  );
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
                onSaved: (value) {
                  _newForm = InstallationFormEntry(
                    id: _newForm.id,
                    formId: _newForm.formId,
                    builderName: _newForm.builderName,
                    orderNumber: _newForm.orderNumber,
                    address: _newForm.address,
                    date: _newForm.date,
                    comments: _newForm.comments,
                    workSiteEvaluator: _newForm.workSiteEvaluator,
                    workSiteEvaluatedDate: _newForm.workSiteEvaluatedDate,
                    workSiteEvaluatorSignature:
                    _newForm.workSiteEvaluatorSignature,
                    builderConfirmation: _newForm.builderConfirmation,
                    builderConfirmationDate: value,
                    builderConfirmationSignature:
                    _newForm.builderConfirmationSignature,
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
              SizedBox(
                height: 175,
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Signature(
                      color: color,
                      key: _sign2,
                      onSign: () {
                        final sign2 = _sign2.currentState;
                        debugPrint(
                            '${sign2.points.length} points in the signature');
                      },
                      backgroundPainter: _WatermarkPaint("2.0", "2.0"),
                      strokeWidth: strokeWidth,
                    ),
                  ),
                  color: Colors.black12,
                ),
              ),
              Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MaterialButton(
                          color: Colors.orange,
                          onPressed: () async {
                            final sign = _sign2.currentState;
                            //retrieve image data, do whatever you want with it (send to server, save locally...)
                            final image = await sign.getData();
                            var data = await image.toByteData(
                                format: ui.ImageByteFormat.png);
                            final encoded =
                            base64.encode(data.buffer.asUint8List());
                            _newForm = InstallationFormEntry(
                              id: _newForm.id,
                              formId: _newForm.formId,
                              builderName: _newForm.builderName,
                              orderNumber: _newForm.orderNumber,
                              address: _newForm.address,
                              date: _newForm.date,
                              comments: _newForm.comments,
                              workSiteEvaluator: _newForm.workSiteEvaluator,
                              workSiteEvaluatedDate:
                              _newForm.workSiteEvaluatedDate,
                              workSiteEvaluatorSignature:
                              _newForm.workSiteEvaluatorSignature,
                              builderConfirmation:
                              _newForm.builderConfirmation,
                              builderConfirmationDate:
                              _newForm.builderConfirmationDate,
                              builderConfirmationSignature: encoded,
                              assessorName: _newForm.assessorName,
                              status: _newForm.status,
                            );
                            setState(() {
                              _img2 = data;
                            });
                            debugPrint("onPressed " + encoded);
                          },
                          child: Text(
                            "Save",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          )),
                      MaterialButton(
                          color: Colors.deepOrange,
                          onPressed: () {
                            final sign = _sign2.currentState;
                            sign.clear();
                            setState(() {
                              _img2 = ByteData(0);
                            });
                            _newForm = InstallationFormEntry(
                              id: _newForm.id,
                              formId: _newForm.formId,
                              builderName: _newForm.builderName,
                              orderNumber: _newForm.orderNumber,
                              address: _newForm.address,
                              date: _newForm.date,
                              comments: _newForm.comments,
                              workSiteEvaluator: _newForm.workSiteEvaluator,
                              workSiteEvaluatedDate:
                              _newForm.workSiteEvaluatedDate,
                              workSiteEvaluatorSignature: '',
                              builderConfirmation:
                              _newForm.builderConfirmation,
                              builderConfirmationDate:
                              _newForm.builderConfirmationDate,
                              builderConfirmationSignature:
                              _newForm.builderConfirmationSignature,
                              assessorName: _newForm.assessorName,
                              status: _newForm.status,
                            );
                            debugPrint("cleared");
                          },
                          child: Text(
                            "Clear",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          )),
                    ],
                  ),
                ],
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
                onSaved: (value) {
                  _newForm = InstallationFormEntry(
                    id: _newForm.id,
                    formId: _newForm.formId,
                    builderName: _newForm.builderName,
                    orderNumber: _newForm.orderNumber,
                    address: _newForm.address,
                    date: _newForm.date,
                    comments: _newForm.comments,
                    workSiteEvaluator: _newForm.workSiteEvaluator,
                    workSiteEvaluatedDate: _newForm.workSiteEvaluatedDate,
                    workSiteEvaluatorSignature:
                    _newForm.workSiteEvaluatorSignature,
                    builderConfirmation: _newForm.builderConfirmation,
                    builderConfirmationDate: _newForm.builderConfirmationDate,
                    builderConfirmationSignature:
                    _newForm.builderConfirmationSignature,
                    assessorName: value,
                    status: _newForm.status,
                  );
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
                child:Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ElevatedButton(
                    onPressed: () {

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
                ),),
            ]))));
  }
}
