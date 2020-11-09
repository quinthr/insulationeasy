import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

import '../install_form.dart';
import '../models/InstallationFormEntry.dart';
import '../models/Checklist.dart';
import '../models/FormImages.dart';
import './hazards_form.dart';

class ChecklistForm extends StatefulWidget {
  @override
  _ChecklistFormState createState() => _ChecklistFormState();
}


Future<dynamic> fetchAndSetFormDataCheckList() async {
  final dataList =
  await ChecklistDB.getAll(await generateFormId());
  var formData = dataList.map(
        (item) => Checklist(
      formId: item['formId'],
      text: item['text'],
    ),
  ).toList();
  print(formData);
  if (formData == null){
    return 0;
  }
  return formData;
}

Future<dynamic> fetchAndSetFormDataImages() async {
  final dataList =
  await FormImagesDB.getAll(await generateFormId());
  var formData = dataList.map(
        (item) => FormImages(
        imageData: item['imageData'],
        imageName: item['imageName'],
        indexnum: item['indexnum'],
    ),
  ).toList();
  if (formData == null){
    return 0;
  }
  return formData;
}

class _ChecklistFormState extends State<ChecklistForm> {
  var _checked1 = false;
  var _checked2 = false;
  var _checked3 = false;
  var _checked4 = false;
  var _checked5 = false;
  var _checked6 = false;
  var _checked11 = false;
  var _checked12 = false;
  var _checked13 = false;
  var _checked14 = false;
  var _checked15 = false;
  var _checked16 = false;
  var _checked17 = false;
  String _intFormId = '';
  String _intComments = '';
  List<Asset> images = List<Asset>();
  List<Image> images2 = List<Image>();
  String _error = 'No Error Dectected';
  var commentsController = TextEditingController();
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

  _ChecklistFormState() {
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
        _intComments = checkifEmpty(val[0].comments.toString());
        commentsController.text = _intComments;
        print(_intComments);
        }));
    fetchAndSetFormDataCheckList().then((val2) => setState(() {
      if(val2.isEmpty){
        print('Empty');
      }
      else{
        for(var i=0; i<val2.length; i++) {
          print(val2.length);
          if(val2[i].text == "_checked1"){
            print(val2[i].text);
            _checked1 = true;
          }
          else if(val2[i].text == "_checked2"){
            print(val2[i].text);
            _checked2 = true;
          }
          else if(val2[i].text == "_checked3"){
            print(val2[i].text);
            _checked3 = true;
          }
          else if(val2[i].text == "_checked4"){
            print(val2[i].text);
            _checked4 = true;
          }
          else if(val2[i].text == "_checked5"){
            print(val2[i].text);
            _checked5 = true;
          }
          else if(val2[i].text == "_checked6"){
            print(val2[i].text);
            _checked6 = true;
          }
          else if(val2[i].text == "_checked11"){
            print(val2[i].text);
            _checked11 = true;
          }
          else if(val2[i].text == "_checked12"){
            print(val2[i].text);
            _checked12 = true;
          }
          else if(val2[i].text == "_checked13"){
            print(val2[i].text);
            _checked13 = true;
          }
          else if(val2[i].text == "_checked14"){
            print(val2[i].text);
            _checked14 = true;
          }
          else if(val2[i].text == "_checked15"){
            print(val2[i].text);
            _checked15 = true;
          }
          else if(val2[i].text == "_checked16"){
            print(val2[i].text);
            _checked16 = true;
          }
          else if(val2[i].text == "_checked17"){
            print(val2[i].text);
            _checked17 = true;
          }

        }
      }
    }));
    fetchAndSetFormDataImages().then((val3) => setState(() {
      if(val3.isEmpty){
        print('Empty');
      }
      else {
        List<Image> imageList = List<Image>();
        print(val3[0].imageData);
        for(var i=0; i<val3.length; i++){
          print(val3[i].imageData);
          if(val3[i].imageData != null){
            final Image image = Image.memory(val3[i].imageData);
            imageList.add(image);
          }
        }
        setState(() {
          images2 = imageList;
        });
      }
    }));
  }

  Widget buildGridView() {
    return GridView.count(
      crossAxisCount: 5,
      children: List.generate(images2.length, (index) {
        print(images);
        Image image = images2[index];
        return image;
      }),
    );
  }

  Future<void> loadAssets() async {
    List<Asset> resultList = List<Asset>();
    String error = 'No Error Dectected';
    List<Image> imageList = List<Image>();

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 10,
        enableCamera: true,
        selectedAssets: images,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          actionBarColor: "#FA9300",
          actionBarTitle: "Select Photos",
          allViewTitle: "Select Photos",
          useDetailsView: true,
          selectCircleStrokeColor: "#FA9300",
        ),
      );
      for(var i=0; i<resultList.length; i++){
        print(resultList[i]);
        final ByteData byteData = await resultList[i].getByteData();
        final Image image = Image.memory(byteData.buffer.asUint8List());
        FormImagesDB.insert('installation_form_images', {
          'imageData': byteData.buffer.asUint8List(),
          'imageName': _intFormId+'-'+i.toString(),
          'indexnum': i,
          'formId': _intFormId,
          'status': 'Ongoing'
        });
        imageList.add(image);
      }
      for(var j=resultList.length; j<10; j++){
        FormImagesDB.insert('installation_form_images', {
          'imageData': null,
          'imageName': _intFormId+'-'+j.toString(),
          'indexnum': j,
          'formId': _intFormId,
          'status': 'Ongoing'
        });
      }
      setState(() {
        images = resultList;
        images2 = imageList;
      });
    } on Exception catch (e) {
      error = e.toString();
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _error = error;
    });
  }

  void _saveForm() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Checklist", style: TextStyle(color: Colors.white)),
          actions: <Widget>[
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(right: 5),
              child: Text("2/4",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold)),
            )
          ],
        ),
        body: FutureBuilder(
            future: fetchAndSetFormData(),
            builder: (ctx, snapshot) => Container(
                    child: SingleChildScrollView(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Column(children: [
                          Text(
                            'Items/Areas to be checked BEFORE commencement of the installation',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          CheckboxListTile(
                              title: Text(
                                'General State of the Work Site is SAFE and tidy',
                              ),
                              value: _checked1,
                              controlAffinity: ListTileControlAffinity.leading,
                              onChanged: (bool value) {
                                if (value == true) {
                                  print('true');
                                  ChecklistDB.insert('installation_form_checklist', {
                                    'formId': _intFormId,
                                    'text':
                                        '_checked1',
                                    'status': 'Ongoing'
                                  });
                                } else {
                                  print('false');
                                  ChecklistDB.deleteCheck(_intFormId,
                                      '_checked1');
                                }
                                print(value);
                                setState(() {
                                  _checked1 = value;
                                });
                              }),
                          CheckboxListTile(
                              title: Text(
                                'Ceiling has no cracks',
                              ),
                              value: _checked2,

                              controlAffinity: ListTileControlAffinity.leading,
                              onChanged: (bool value) {
                                if (value == true) {
                                  print('true');
                                  ChecklistDB.insert('installation_form_checklist', {
                                    'formId': _intFormId,
                                    'text':
                                    '_checked2',
                                    'status': 'Ongoing'
                                  });
                                } else {
                                  print('false');
                                  ChecklistDB.deleteCheck(_intFormId,
                                      '_checked2');
                                }
                                setState(() {
                                  _checked2 = value;
                                });
                              }),
                          CheckboxListTile(
                              title: Text(
                                'Floors clean and tidy',
                              ),
                              value: _checked3,
                              controlAffinity: ListTileControlAffinity.leading,
                              onChanged: (bool value) {
                                if (value == true) {
                                  print('true');
                                  ChecklistDB.insert('installation_form_checklist', {
                                    'formId': _intFormId,
                                    'text':
                                    '_checked3',
                                    'status': 'Ongoing'
                                  });
                                } else {
                                  print('false');
                                  ChecklistDB.deleteCheck(_intFormId,
                                      '_checked3');
                                }
                                setState(() {
                                  _checked3 = value;
                                });
                              }),
                          CheckboxListTile(
                              title: Text(
                                'Lights in place & in working order',
                              ),
                              value: _checked4,
                              controlAffinity: ListTileControlAffinity.leading,
                              onChanged: (bool value) {
                                if (value == true) {
                                  print('true');
                                  ChecklistDB.insert('installation_form_checklist', {
                                    'formId': _intFormId,
                                    'text':
                                    '_checked4',
                                    'status': 'Ongoing'
                                  });
                                } else {
                                  print('false');
                                  ChecklistDB.deleteCheck(_intFormId,
                                      '_checked4');
                                }
                                setState(() {
                                  _checked4 = value;
                                });
                              }),
                          CheckboxListTile(
                              title: Text(
                                'A safety environment exists',
                              ),
                              value: _checked5,
                              controlAffinity: ListTileControlAffinity.leading,
                              onChanged: (bool value) {
                                if (value == true) {
                                  print('true');
                                  ChecklistDB.insert('installation_form_checklist', {
                                    'formId': _intFormId,
                                    'text':
                                    '_checked5',
                                    'status': 'Ongoing'
                                  });
                                } else {
                                  print('false');
                                  ChecklistDB.deleteCheck(_intFormId,
                                      '_checked5');
                                }
                                setState(() {
                                  _checked5 = value;
                                });
                              }),
                          CheckboxListTile(
                              title: Text(
                                'Is the Ceiling lining made of asbestos?',
                              ),
                              value: _checked6,
                              controlAffinity: ListTileControlAffinity.leading,
                              onChanged: (bool value) {
                                if (value == true) {
                                  print('true');
                                  ChecklistDB.insert('installation_form_checklist', {
                                    'formId': _intFormId,
                                    'text':
                                    '_checked6',
                                    'status': 'Ongoing'
                                  });
                                } else {
                                  print('false');
                                  ChecklistDB.deleteCheck(_intFormId,
                                      '_checked6');
                                }
                                setState(() {
                                  _checked6 = value;
                                });
                              }),
                          SizedBox(
                            height: 15.0,
                          ),
                          Text(
                            'Check all areas of the ceiling, if the ceiling is asbestos or you are unsure of its composition you must assume it is ASBESTOS and follow Higgins Asbestos Management Plan)',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          TextFormField(
                            keyboardType: TextInputType.multiline,
                            controller: commentsController,
                            maxLines: null,
                            decoration: InputDecoration(
                              labelText: '',
                              contentPadding: EdgeInsets.all(3),
                              border: OutlineInputBorder(),
                              helperText: 'Write comments here...',
                            ),
                            onChanged: (value) {
                              _newForm = InstallationFormEntry(
                                formId: _intFormId,
                                builderName: _newForm.builderName,
                                orderNumber: _newForm.orderNumber,
                                address: _newForm.address,
                                date: _newForm.date,
                                comments: value,
                                workSiteEvaluator: _newForm.workSiteEvaluator,
                                workSiteEvaluatedDate:
                                _newForm.workSiteEvaluatedDate,
                                builderConfirmation:
                                _newForm.builderConfirmation,
                                builderConfirmationDate:
                                _newForm.builderConfirmationDate,
                                assessorName: _newForm.assessorName,
                                status: _newForm.status,
                              );
                              InstallationFormEntryDB.update(
                                  _intFormId, _newForm);
                            },
                            onFieldSubmitted: (value) {
                              _newForm = InstallationFormEntry(
                                formId: _intFormId,
                                builderName: _newForm.builderName,
                                orderNumber: _newForm.orderNumber,
                                address: _newForm.address,
                                date: _newForm.date,
                                comments: value,
                                workSiteEvaluator: _newForm.workSiteEvaluator,
                                workSiteEvaluatedDate:
                                _newForm.workSiteEvaluatedDate,
                                builderConfirmation:
                                _newForm.builderConfirmation,
                                builderConfirmationDate:
                                _newForm.builderConfirmationDate,
                                assessorName: _newForm.assessorName,
                                status: _newForm.status,
                              );
                              InstallationFormEntryDB.update(
                                  _intFormId, _newForm);
                            },
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Text(
                            'Items/Areas to be checked AFTER commencement of the installation',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          CheckboxListTile(
                              title: Text(
                                'General State of the Work Site is SAFE and tidy',
                              ),
                              value: _checked11,
                              controlAffinity: ListTileControlAffinity.leading,
                              onChanged: (bool value) {
                                if (value == true) {
                                  print('true');
                                  ChecklistDB.insert('installation_form_checklist', {
                                    'formId': _intFormId,
                                    'text':
                                    '_checked11',
                                    'status': 'Ongoing'
                                  });
                                } else {
                                  print('false');
                                  ChecklistDB.deleteCheck(_intFormId,
                                      '_checked11');
                                }
                                setState(() {
                                  _checked11 = value;
                                });
                              }),
                          CheckboxListTile(
                              title: Text(
                                'Ceiling has no cracks',
                              ),
                              value: _checked12,
                              controlAffinity: ListTileControlAffinity.leading,
                              onChanged: (bool value) {
                                if (value == true) {
                                  print('true');
                                  ChecklistDB.insert('installation_form_checklist', {
                                    'formId': _intFormId,
                                    'text':
                                    '_checked12',
                                    'status': 'Ongoing'
                                  });
                                } else {
                                  print('false');
                                  ChecklistDB.deleteCheck(_intFormId,
                                      '_checked12');
                                }
                                setState(() {
                                  _checked12 = value;
                                });
                              }),
                          CheckboxListTile(
                              title: Text(
                                'Floors clean and tidy',
                              ),
                              value: _checked13,
                              controlAffinity: ListTileControlAffinity.leading,
                              onChanged: (bool value) {
                                if (value == true) {
                                  print('true');
                                  ChecklistDB.insert('installation_form_checklist', {
                                    'formId': _intFormId,
                                    'text':
                                    '_checked13',
                                    'status': 'Ongoing'
                                  });
                                } else {
                                  print('false');
                                  ChecklistDB.deleteCheck(_intFormId,
                                      '_checked13');
                                }
                                setState(() {
                                  _checked13 = value;
                                });
                              }),
                          CheckboxListTile(
                              title: Text(
                                'Lights in place & in working order',
                              ),
                              value: _checked14,
                              controlAffinity: ListTileControlAffinity.leading,
                              onChanged: (bool value) {
                                if (value == true) {
                                  print('true');
                                  ChecklistDB.insert('installation_form_checklist', {
                                    'formId': _intFormId,
                                    'text':
                                    '_checked14',
                                    'status': 'Ongoing'
                                  });
                                } else {
                                  print('false');
                                  ChecklistDB.deleteCheck(_intFormId,
                                      '_checked14');
                                }
                                setState(() {
                                  _checked14 = value;
                                });
                              }),
                          CheckboxListTile(
                              title: Text(
                                'Insulation packaging removed from site',
                              ),
                              value: _checked15,
                              controlAffinity: ListTileControlAffinity.leading,
                              onChanged: (bool value) {
                                if (value == true) {
                                  print('true');
                                  ChecklistDB.insert('installation_form_checklist', {
                                    'formId': _intFormId,
                                    'text':
                                    '_checked15',
                                    'status': 'Ongoing'
                                  });
                                } else {
                                  print('false');
                                  ChecklistDB.deleteCheck(_intFormId,
                                      '_checked15');
                                }
                                setState(() {
                                  _checked15 = value;
                                });
                              }),
                          CheckboxListTile(
                              title: Text(
                                'Access Aperture clean',
                              ),
                              value: _checked16,
                              controlAffinity: ListTileControlAffinity.leading,
                              onChanged: (bool value) {
                                if (value == true) {
                                  print('true');
                                  ChecklistDB.insert('installation_form_checklist', {
                                    'formId': _intFormId,
                                    'text':
                                    '_checked16',
                                    'status': 'Ongoing'
                                  });
                                } else {
                                  print('false');
                                  ChecklistDB.deleteCheck(_intFormId,
                                      '_checked16');
                                }
                                setState(() {
                                  _checked16 = value;
                                });
                              }),
                          CheckboxListTile(
                              title: Text(
                                'Default Minimum clearance of insulation around all recessed lights And electrical equipment achieved as per AS/NZS 3000:2007',
                              ),
                              value: _checked17,
                              controlAffinity: ListTileControlAffinity.leading,
                              onChanged: (bool value) {
                                if (value == true) {
                                  print('true');
                                  ChecklistDB.insert('installation_form_checklist', {
                                    'formId': _intFormId,
                                    'text':
                                    '_checked17',
                                    'status': 'Ongoing'
                                  });
                                } else {
                                  print('false');
                                  ChecklistDB.deleteCheck(_intFormId,
                                      '_checked17');
                                }
                                setState(() {
                                  _checked17 = value;
                                });
                              }),
                          SizedBox(
                            height: 20.0,
                          ),
                          SizedBox(
                            height: 220,
                            child: Column(
                              children: <Widget>[
                                RaisedButton(
                                  child: Text("Upload Images"),
                                  onPressed: loadAssets,
                                ),
                                Expanded(
                                  child: buildGridView(),
                                ),
                                Align(
                                    alignment: Alignment.centerLeft,
                                    child: Container(
                                        child: Text(
                                      'Upload at least 6 pictures including the site board:',
                                      textAlign: TextAlign.left,
                                    ))),
                              ],
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 16.0),
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HazardsForm()),
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
                        ]))
            )
        )
    );
  }
}
