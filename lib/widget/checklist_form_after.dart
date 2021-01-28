import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../install_form.dart';
import '../models/Checklist.dart';
import './hazards_form.dart';
import './image_upload_form.dart';

class ChecklistFormAfter extends StatefulWidget {
  @override
  _ChecklistFormAfterState createState() => _ChecklistFormAfterState();
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
  if (formData == null){
    return 0;
  }
  return formData;
}

class _ChecklistFormAfterState extends State<ChecklistFormAfter> {
  var _checked11 = false;
  var _checked12 = false;
  var _checked13 = false;
  var _checked14 = false;
  var _checked15 = false;
  var _checked16 = false;
  var _checked17 = false;
  String _intFormId = '';
  String _intUser = '';
  @override
  void initState() {
    super.initState();
  }
  _ChecklistFormAfterState() {
    fetchFormData().then((val) => setState(() {
      _intFormId = val[0].formId.toString();
      _intUser = val[0].workerName.toString();
    }));
    fetchAndSetFormDataCheckList().then((val2) => setState(() {
      if(val2.isEmpty){
        print('Empty');
      }
      else{
        for(var i=0; i<val2.length; i++) {
          if(val2[i].text == "_checked11"){
            _checked11 = true;
          }
          else if(val2[i].text == "_checked12"){
            _checked12 = true;
          }
          else if(val2[i].text == "_checked13"){
            _checked13 = true;
          }
          else if(val2[i].text == "_checked14"){
            _checked14 = true;
          }
          else if(val2[i].text == "_checked15"){
            _checked15 = true;
          }
          else if(val2[i].text == "_checked16"){
            _checked16 = true;
          }
          else if(val2[i].text == "_checked17"){
            _checked17 = true;
          }
        }
      }
    }));
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
        appBar: AppBar(
          title: Text("After Work Checklist", style: TextStyle(color: Colors.white)),
          actions: <Widget>[
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(right: 5),
              child: Text("3/6",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold)),
            )
          ],
        ),
        body: FutureBuilder(
            future: fetchFormData(),
            builder: (ctx, snapshot) => Container(
                child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Column(children: [
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
                              ChecklistDB.insert('installation_form_checklist', {
                                'formId': _intFormId,
                                'text':
                                '_checked11',
                                'status': 'Ongoing'
                              });
                            } else {
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
                              ChecklistDB.insert('installation_form_checklist', {
                                'formId': _intFormId,
                                'text':
                                '_checked12',
                                'status': 'Ongoing'
                              });
                            } else {
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
                              ChecklistDB.insert('installation_form_checklist', {
                                'formId': _intFormId,
                                'text':
                                '_checked13',
                                'status': 'Ongoing'
                              });
                            } else {
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
                              ChecklistDB.insert('installation_form_checklist', {
                                'formId': _intFormId,
                                'text':
                                '_checked14',
                                'status': 'Ongoing'
                              });
                            } else {
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
                              ChecklistDB.insert('installation_form_checklist', {
                                'formId': _intFormId,
                                'text':
                                '_checked15',
                                'status': 'Ongoing'
                              });
                            } else {
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
                              ChecklistDB.insert('installation_form_checklist', {
                                'formId': _intFormId,
                                'text':
                                '_checked16',
                                'status': 'Ongoing'
                              });
                            } else {
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
                              ChecklistDB.insert('installation_form_checklist', {
                                'formId': _intFormId,
                                'text':
                                '_checked17',
                                'status': 'Ongoing'
                              });
                            } else {
                              ChecklistDB.deleteCheck(_intFormId,
                                  '_checked17');
                            }
                            setState(() {
                              _checked17 = value;
                            });
                          }),
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
                                    settings: RouteSettings(name: "imageUploadForm"),
                                    builder: (context) => ImageUploadForm()),
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
