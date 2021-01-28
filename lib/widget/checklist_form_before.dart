import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../install_form.dart';
import '../models/InstallationFormEntry.dart';
import '../models/Checklist.dart';
import './hazards_form.dart';

class ChecklistFormBefore extends StatefulWidget {
  @override
  _ChecklistFormBeforeState createState() => _ChecklistFormBeforeState();
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

class _ChecklistFormBeforeState extends State<ChecklistFormBefore> {
  final _form2 = GlobalKey<FormState>();
  FocusNode commentFocusNode;
  var _checked1 = false;
  var _checked2 = false;
  var _checked3 = false;
  var _checked4 = false;
  var _checked5 = false;
  var _checked6 = false;
  String _intFormId = '';
  String _intComments = '';
  String _intUser = '';
  bool validator = false;
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
    workerName: '',
  );
  final GlobalKey<ScaffoldState> _imageFormScaffold = new GlobalKey<ScaffoldState>();
  final imageFormSnackBar = SnackBar(content: Text('Please take the pictures before proceeding.'), duration: Duration(seconds: 2),);
  @override
  void initState() {
    super.initState();
    commentFocusNode = FocusNode();
  }
  _ChecklistFormBeforeState() {
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
          workSiteEvaluatedDate:
          checkifEmpty(val[0].workSiteEvaluatedDate.toString()),
          builderConfirmation:
          checkifEmpty(val[0].builderConfirmation.toString()),
          builderConfirmationDate:
          checkifEmpty(val[0].builderConfirmationDate.toString()),
          assessorName: checkifEmpty(val[0].assessorName.toString()),
          status: checkifEmpty(val[0].status.toString()),
          workerName: val[0].workerName.toString()
      );
      _intFormId = val[0].formId.toString();
      _intUser = val[0].workerName.toString();
      _intComments = checkifEmpty(val[0].comments.toString());
      commentsController.text = _intComments;
    }));
    fetchAndSetFormDataCheckList().then((val2) => setState(() {
      if(val2.isEmpty){
        print('Empty');
      }
      else{
        for(var i=0; i<val2.length; i++) {
          if(val2[i].text == "_checked1"){
            _checked1 = true;
          }
          else if(val2[i].text == "_checked2"){
            _checked2 = true;
          }
          else if(val2[i].text == "_checked3"){
            _checked3 = true;
          }
          else if(val2[i].text == "_checked4"){
            _checked4 = true;
          }
          else if(val2[i].text == "_checked5"){
            _checked5 = true;
          }
          else if(val2[i].text == "_checked6"){
            _checked6 = true;
          }
        }
      }
    }));
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    commentFocusNode.dispose();

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
        key: _imageFormScaffold,
        appBar: AppBar(
          title: Text("Before Work Checklist", style: TextStyle(color: Colors.white)),
          actions: <Widget>[
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(right: 5),
              child: Text("1/6",
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
                              ChecklistDB.insert('installation_form_checklist', {
                                'formId': _intFormId,
                                'text':
                                '_checked1',
                                'status': 'Ongoing'
                              });
                            } else {
                              ChecklistDB.deleteCheck(_intFormId,
                                  '_checked1');
                            }
                            commentFocusNode.unfocus();
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
                              ChecklistDB.insert('installation_form_checklist', {
                                'formId': _intFormId,
                                'text':
                                '_checked2',
                                'status': 'Ongoing'
                              });
                            } else {
                              ChecklistDB.deleteCheck(_intFormId,
                                  '_checked2');
                            }
                            commentFocusNode.unfocus();
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
                              ChecklistDB.insert('installation_form_checklist', {
                                'formId': _intFormId,
                                'text':
                                '_checked3',
                                'status': 'Ongoing'
                              });
                            } else {
                              ChecklistDB.deleteCheck(_intFormId,
                                  '_checked3');
                            }
                            commentFocusNode.unfocus();
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
                              ChecklistDB.insert('installation_form_checklist', {
                                'formId': _intFormId,
                                'text':
                                '_checked4',
                                'status': 'Ongoing'
                              });
                            } else {
                              ChecklistDB.deleteCheck(_intFormId,
                                  '_checked4');
                            }
                            commentFocusNode.unfocus();
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
                              ChecklistDB.insert('installation_form_checklist', {
                                'formId': _intFormId,
                                'text':
                                '_checked5',
                                'status': 'Ongoing'
                              });
                            } else {
                              ChecklistDB.deleteCheck(_intFormId,
                                  '_checked5');
                            }
                            commentFocusNode.unfocus();
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
                              ChecklistDB.insert('installation_form_checklist', {
                                'formId': _intFormId,
                                'text':
                                '_checked6',
                                'status': 'Ongoing'
                              });
                            } else {
                              ChecklistDB.deleteCheck(_intFormId,
                                  '_checked6');
                            }
                            commentFocusNode.unfocus();
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
                        focusNode: commentFocusNode,
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
                            workerName: _intUser,
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
                            workerName: _intUser,
                          );
                          InstallationFormEntryDB.update(
                              _intFormId, _newForm);
                        },
                      ),
                      Form(
                        key: _form2,
                        child: SingleChildScrollView(
                            padding: EdgeInsets.symmetric(horizontal: 0),
                            child: Column(
                              children: <Widget>[
                                CheckboxListTile(
                                    title: Text(
                                      'Are pictures taken before install begins?',
                                    ),
                                    contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                                    value: validator,
                                    controlAffinity: ListTileControlAffinity.leading,
                                    onChanged: (bool value) {
                                      commentFocusNode.unfocus();
                                      setState(() {
                                        validator = value;
                                      });
                                }),
                                Container(
                                  width: double.infinity,
                                  child: Padding(
                                    padding:
                                    const EdgeInsets.symmetric(vertical: 16.0),
                                    child: ElevatedButton(
                                      onPressed: () {
                                        if(!validator){
                                          _imageFormScaffold.currentState.showSnackBar(imageFormSnackBar);
                                          return;
                                        }
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              settings: RouteSettings(name: "hazardsform"),
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
                              ],
                            )),
                      ),
                    ]))
            )
        )
    );
  }
}