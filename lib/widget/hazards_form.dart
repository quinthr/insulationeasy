import 'package:flutter/material.dart';
import 'package:mobile_app/widget/final_form.dart';

import '../models/Hazards.dart';
import '../models/InstallationFormEntry.dart';
import '../install_form.dart';

class HazardsForm extends StatefulWidget {
  @override
  _HazardsFormState createState() => _HazardsFormState();
}

Future<dynamic> fetchAndSetHazard(String hazardName) async{
  final dataList = await HazardsDB.getOneFormData(await generateFormId(), hazardName);

  var formData = dataList.map(
        (item) => Hazards(
      hazardName: item['hazardName'],
      probability: item['probability'],
      consequence: item['consequence'],
      risk: item['risk'],
      controlMeasure: item['controlMeasure'],
      person: item['person'],
      status: item['status'],
    ),
  ).toList();
  print(formData);
  if (formData == null){
    return 0;
  }
  return formData;
}

class _HazardsFormState extends State<HazardsForm> {
  String dropdownValue1 = 'Not applicable';
  String dropdownValue2 = 'Not applicable';
  String dropdownValue3 = 'Not applicable';
  String dropdownValue4 = 'Not applicable';
  String dropdownValue5 = 'Not applicable';
  String dropdownValue6 = 'Not applicable';
  String dropdownValue7 = 'Not applicable';
  String dropdownValue8 = 'Not applicable';
  String dropdownValue9 = 'Not applicable';
  String dropdownValue10 = 'Not applicable';
  String dropdownValue11 = 'Not applicable';
  String dropdownValue12 = 'Not applicable';
  String dropdownValue13 = 'Not applicable';
  String dropdownValue14 = 'Not applicable';
  String dropdownValue15 = 'Not applicable';
  String _intFormId = '';
  var _hazard1 = Hazards(
    formId: '',
    hazardName: '',
    probability: '',
    consequence: '',
    risk: '',
    controlMeasure: '',
    person: '',
    status: ''
  );
  var _hazard2 = Hazards(
      formId: '',
      hazardName: '',
      probability: '',
      consequence: '',
      risk: '',
      controlMeasure: '',
      person: '',
      status: ''
  );
  var _hazard3 = Hazards(
      formId: '',
      hazardName: '',
      probability: '',
      consequence: '',
      risk: '',
      controlMeasure: '',
      person: '',
      status: ''
  );
  var _hazard4 = Hazards(
      formId: '',
      hazardName: '',
      probability: '',
      consequence: '',
      risk: '',
      controlMeasure: '',
      person: '',
      status: ''
  );
  var _hazard5 = Hazards(
      formId: '',
      hazardName: '',
      probability: '',
      consequence: '',
      risk: '',
      controlMeasure: '',
      person: '',
      status: ''
  );
  _HazardsFormState() {
    fetchAndSetFormData().then((val) =>
        setState(() {
          _intFormId = val[0].formId.toString();
        }));
    fetchAndSetHazard('hazard1').then((val2) =>
      setState(() {
        _hazard1 = Hazards(
          formId: _intFormId,
          hazardName: val2[0].hazardName,
          probability: val2[0].probability,
          consequence: val2[0].consequence,
          risk: val2[0].risk,
          controlMeasure: val2[0].controlMeasure,
          person: val2[0].person,
          status: val2[0].status,
        );
        dropdownValue1 = val2[0].probability;
        dropdownValue2 = val2[0].consequence;
        dropdownValue3 = val2[0].risk;
      })
    );
    fetchAndSetHazard('hazard2').then((val2) =>
        setState(() {
          _hazard2 = Hazards(
            formId: _intFormId,
            hazardName: val2[0].hazardName,
            probability: val2[0].probability,
            consequence: val2[0].consequence,
            risk: val2[0].risk,
            controlMeasure: val2[0].controlMeasure,
            person: val2[0].person,
            status: val2[0].status,
          );
          dropdownValue4 = val2[0].probability;
          dropdownValue5 = val2[0].consequence;
          dropdownValue6 = val2[0].risk;
        })
    );
    fetchAndSetHazard('hazard3').then((val2) =>
        setState(() {
          _hazard3 = Hazards(
            formId: _intFormId,
            hazardName: val2[0].hazardName,
            probability: val2[0].probability,
            consequence: val2[0].consequence,
            risk: val2[0].risk,
            controlMeasure: val2[0].controlMeasure,
            person: val2[0].person,
            status: val2[0].status,
          );
          dropdownValue7 = val2[0].probability;
          dropdownValue8 = val2[0].consequence;
          dropdownValue9 = val2[0].risk;
        })
    );
    fetchAndSetHazard('hazard4').then((val2) =>
        setState(() {
          _hazard4 = Hazards(
            formId: _intFormId,
            hazardName: val2[0].hazardName,
            probability: val2[0].probability,
            consequence: val2[0].consequence,
            risk: val2[0].risk,
            controlMeasure: val2[0].controlMeasure,
            person: val2[0].person,
            status: val2[0].status,
          );
          dropdownValue10 = val2[0].probability;
          dropdownValue11 = val2[0].consequence;
          dropdownValue12 = val2[0].risk;
        })
    );
    fetchAndSetHazard('hazard5').then((val2) =>
        setState(() {
          _hazard5 = Hazards(
            formId: _intFormId,
            hazardName: val2[0].hazardName,
            probability: val2[0].probability,
            consequence: val2[0].consequence,
            risk: val2[0].risk,
            controlMeasure: val2[0].controlMeasure,
            person: val2[0].person,
            status: val2[0].status,
          );
          dropdownValue13 = val2[0].probability;
          dropdownValue14 = val2[0].consequence;
          dropdownValue15 = val2[0].risk;
        })
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title:
              Text("Hazards", style: TextStyle(color: Colors.white)),
          actions: <Widget>[
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(right:5),
              child: Text("3/4", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
            )
          ],
        ),
        body: Container(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 10),
          child:Column(
            children: [
              SizedBox(
                height: 20.0,
              ),
              Text(
                'Job Safety Analysis (JSA) Worksheet',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
              ExpansionTile(
                key: PageStorageKey('hazard1'),
                title: Text(
                  'Electrocution',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                children: [
                  Text(
                    'Probability',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.black12,
                      ),
                      child: DropdownButton<String>(
                          value: dropdownValue1,
                          elevation: 16,
                          underline: Container(
                            height: 2,
                          ),
                          items: <String>[
                            'A - Common or repeating',
                            'B - Known to occur',
                            'C - Could occur',
                            'D - Not likely to happen',
                            'E - Practically impossible',
                            'Not applicable',
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String newValue) {
                            HazardsDB.insert('installation_form_hazards', {
                              'hazardId': _intFormId+'-hazard1',
                              'formId': _intFormId,
                              'hazardName': 'hazard1',
                              'probability': newValue,
                              'consequence': _hazard1.consequence,
                              'risk': _hazard1.risk,
                              'controlMeasure': _hazard1.controlMeasure,
                              'person': _hazard1.person,
                              'status': _hazard1.status,
                            });
                            setState(() {
                              _hazard1 = Hazards(
                                formId: _intFormId,
                                hazardName: 'hazard1',
                                probability: newValue,
                                consequence: _hazard1.consequence,
                                risk: _hazard1.risk,
                                controlMeasure: _hazard1.controlMeasure,
                                person: _hazard1.person,
                                status: _hazard1.status,
                              );
                              dropdownValue1 = newValue;
                            });
                          })),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    'Consequence',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.black12,
                      ),
                      child: DropdownButton<String>(
                          value: dropdownValue2,
                          elevation: 16,
                          underline: Container(
                            height: 2,
                          ),
                          items: <String>[
                            '1 - Fatal or permanent serious injury',
                            '2 - Lost time injury or illness',
                            '3 - Medical treatment required',
                            '4 - First aid treatment',
                            '5 - Incident report only',
                            'Not applicable',
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String newValue) {
                            HazardsDB.insert('installation_form_hazards', {
                              'hazardId': _intFormId+'-hazard1',
                              'formId': _intFormId,
                              'hazardName': 'hazard1',
                              'probability': _hazard1.probability,
                              'consequence': newValue,
                              'risk': _hazard1.risk,
                              'controlMeasure': _hazard1.controlMeasure,
                              'person': _hazard1.person,
                              'status': _hazard1.status,
                            });
                            setState(() {
                              _hazard1 = Hazards(
                                formId: _intFormId,
                                hazardName: 'hazard1',
                                probability: _hazard1.probability,
                                consequence: newValue,
                                risk: _hazard1.risk,
                                controlMeasure: _hazard1.controlMeasure,
                                person: _hazard1.person,
                                status: _hazard1.status,
                              );
                              dropdownValue2 = newValue;
                            });
                          })),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    'Risk',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Container(
                      width: double.infinity,
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.black12,
                      ),
                      child: DropdownButton<String>(
                          value: dropdownValue3,
                          elevation: 16,
                          underline: Container(
                            height: 2,
                          ),
                          items: <String>[
                            'High',
                            'Significant',
                            'Moderate',
                            'Low',
                            'Not applicable',
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String newValue) {
                            HazardsDB.insert('installation_form_hazards', {
                              'hazardId': _intFormId+'-hazard1',
                              'formId': _intFormId,
                              'hazardName': 'hazard1',
                              'probability': _hazard1.probability,
                              'consequence': _hazard1.consequence,
                              'risk': newValue,
                              'controlMeasure': _hazard1.controlMeasure,
                              'person': _hazard1.person,
                              'status': _hazard1.status,
                            });
                            setState(() {
                              _hazard1 = Hazards(
                                formId: _intFormId,
                                hazardName: 'hazard1',
                                probability: _hazard1.probability,
                                consequence: _hazard1.consequence,
                                risk: newValue,
                                controlMeasure: _hazard1.controlMeasure,
                                person: _hazard1.person,
                                status: _hazard1.status,
                              );
                              dropdownValue3 = newValue;
                            });
                          })),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    key: PageStorageKey('controlMeasure1'),
                    initialValue: _hazard1.controlMeasure,
                    onChanged: (value) {
                      HazardsDB.insert('installation_form_hazards', {
                        'hazardId': _intFormId+'-hazard1',
                        'formId': _intFormId,
                        'hazardName': 'hazard1',
                        'probability': _hazard1.probability,
                        'consequence': _hazard1.consequence,
                        'risk': _hazard1.risk,
                        'controlMeasure': value,
                        'person': _hazard1.person,
                        'status': _hazard1.status,
                      });
                      setState(() {
                        _hazard1 = Hazards(
                          formId: _intFormId,
                          hazardName: 'hazard1',
                          probability: _hazard1.probability,
                          consequence: _hazard1.consequence,
                          risk: _hazard1.risk,
                          controlMeasure: value,
                          person: _hazard1.person,
                          status: _hazard1.status,
                        );
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'Control Measure',
                      contentPadding: EdgeInsets.all(3),
                      border: OutlineInputBorder(),
                      helperText:
                          'Eliminate, Isolate, minimise to a safe level (state how)',
                    ),
                    textInputAction: TextInputAction.next,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    key: PageStorageKey('person1'),
                    initialValue: _hazard1.person,
                    onChanged: (value) {
                      HazardsDB.insert('installation_form_hazards', {
                        'hazardId': _intFormId+'-hazard1',
                        'formId': _intFormId,
                        'hazardName': 'hazard1',
                        'probability': _hazard1.probability,
                        'consequence': _hazard1.consequence,
                        'risk': _hazard1.risk,
                        'controlMeasure': _hazard1.controlMeasure,
                        'person': value,
                        'status': _hazard1.status,
                      });
                      setState(() {
                        _hazard1 = Hazards(
                          formId: _intFormId,
                          hazardName: 'hazard1',
                          probability: _hazard1.probability,
                          consequence: _hazard1.consequence,
                          risk: _hazard1.risk,
                          controlMeasure: _hazard1.controlMeasure,
                          person: value,
                          status: _hazard1.status,
                        );
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'Person',
                      contentPadding: EdgeInsets.all(3),
                      border: OutlineInputBorder(),
                      helperText: 'The person responsible to make this happen',
                    ),
                    textInputAction: TextInputAction.next,
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              ExpansionTile(
                key: PageStorageKey('hazard2'),
                title: Text(
                  'Biohazards, Snakes and Spiders',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                children: [
                  Text(
                    'Probability',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.black12,
                      ),
                      child: DropdownButton<String>(
                          value: dropdownValue4,
                          elevation: 16,
                          underline: Container(
                            height: 2,
                          ),
                          items: <String>[
                            'A - Common or repeating',
                            'B - Known to occur',
                            'C - Could occur',
                            'D - Not likely to happen',
                            'E - Practically impossible',
                            'Not applicable',
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String newValue) {
                            HazardsDB.insert('installation_form_hazards', {
                              'hazardId': _intFormId+'-hazard2',
                              'formId': _intFormId,
                              'hazardName': 'hazard2',
                              'probability': newValue,
                              'consequence': _hazard2.consequence,
                              'risk': _hazard2.risk,
                              'controlMeasure': _hazard2.controlMeasure,
                              'person': _hazard2.person,
                              'status': _hazard2.status,
                            });
                            setState(() {
                              _hazard2 = Hazards(
                                formId: _intFormId,
                                hazardName: 'hazard2',
                                probability: newValue,
                                consequence: _hazard2.consequence,
                                risk: _hazard2.risk,
                                controlMeasure: _hazard2.controlMeasure,
                                person: _hazard2.person,
                                status: _hazard2.status,
                              );
                              dropdownValue4 = newValue;
                            });
                          })),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    'Consequence',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.black12,
                      ),
                      child: DropdownButton<String>(
                          value: dropdownValue5,
                          elevation: 16,
                          underline: Container(
                            height: 2,
                          ),
                          items: <String>[
                            '1 - Fatal or permanent serious injury',
                            '2 - Lost time injury or illness',
                            '3 - Medical treatment required',
                            '4 - First aid treatment',
                            '5 - Incident report only',
                            'Not applicable',
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String newValue) {
                            HazardsDB.insert('installation_form_hazards', {
                              'hazardId': _intFormId+'-hazard2',
                              'formId': _intFormId,
                              'hazardName': 'hazard2',
                              'probability': _hazard2.probability,
                              'consequence': newValue,
                              'risk': _hazard2.risk,
                              'controlMeasure': _hazard2.controlMeasure,
                              'person': _hazard2.person,
                              'status': _hazard2.status,
                            });
                            setState(() {
                              _hazard2 = Hazards(
                                formId: _intFormId,
                                hazardName: 'hazard2',
                                probability: _hazard2.probability,
                                consequence: newValue,
                                risk: _hazard2.risk,
                                controlMeasure: _hazard2.controlMeasure,
                                person: _hazard2.person,
                                status: _hazard2.status,
                              );
                              dropdownValue5 = newValue;
                            });
                          })),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    'Risk',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Container(
                      width: double.infinity,
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.black12,
                      ),
                      child: DropdownButton<String>(
                          value: dropdownValue6,
                          elevation: 16,
                          underline: Container(
                            height: 2,
                          ),
                          items: <String>[
                            'High',
                            'Significant',
                            'Moderate',
                            'Low',
                            'Not applicable',
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String newValue) {
                            HazardsDB.insert('installation_form_hazards', {
                              'hazardId': _intFormId+'-hazard2',
                              'formId': _intFormId,
                              'hazardName': 'hazard2',
                              'probability': _hazard2.probability,
                              'consequence': _hazard2.consequence,
                              'risk': newValue,
                              'controlMeasure': _hazard2.controlMeasure,
                              'person': _hazard2.person,
                              'status': _hazard2.status,
                            });
                            setState(() {
                              _hazard2 = Hazards(
                                formId: _intFormId,
                                hazardName: 'hazard2',
                                probability: _hazard2.probability,
                                consequence: _hazard2.consequence,
                                risk: newValue,
                                controlMeasure: _hazard2.controlMeasure,
                                person: _hazard2.person,
                                status: _hazard2.status,
                              );
                              dropdownValue6 = newValue;
                            });
                          })),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    key: PageStorageKey('controlMeasure2'),
                    initialValue: _hazard2.controlMeasure,
                    onChanged: (value) {
                      HazardsDB.insert('installation_form_hazards', {
                        'hazardId': _intFormId+'-hazard2',
                        'formId': _intFormId,
                        'hazardName': 'hazard2',
                        'probability': _hazard2.probability,
                        'consequence': _hazard2.consequence,
                        'risk': _hazard2.risk,
                        'controlMeasure': value,
                        'person': _hazard2.person,
                        'status': _hazard2.status,
                      });
                      setState(() {
                        _hazard2 = Hazards(
                          formId: _intFormId,
                          hazardName: 'hazard2',
                          probability: _hazard2.probability,
                          consequence: _hazard2.consequence,
                          risk: _hazard2.risk,
                          controlMeasure: value,
                          person: _hazard2.person,
                          status: _hazard2.status,
                        );
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'Control Measure',
                      contentPadding: EdgeInsets.all(3),
                      border: OutlineInputBorder(),
                      helperText:
                          'Eliminate, Isolate, minimise to a safe level (state how)',
                    ),
                    textInputAction: TextInputAction.next,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    key: PageStorageKey('person2'),
                    initialValue: _hazard2.person,
                    onChanged: (value) {
                      HazardsDB.insert('installation_form_hazards', {
                        'hazardId': _intFormId+'-hazard2',
                        'formId': _intFormId,
                        'hazardName': 'hazard2',
                        'probability': _hazard2.probability,
                        'consequence': _hazard2.consequence,
                        'risk': _hazard2.risk,
                        'controlMeasure': _hazard2.controlMeasure,
                        'person': value,
                        'status': _hazard2.status,
                      });
                      setState(() {
                        _hazard2 = Hazards(
                          formId: _intFormId,
                          hazardName: 'hazard2',
                          probability: _hazard2.probability,
                          consequence: _hazard2.consequence,
                          risk: _hazard2.risk,
                          controlMeasure: _hazard2.controlMeasure,
                          person: value,
                          status: _hazard2.status,
                        );
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'Person',
                      contentPadding: EdgeInsets.all(3),
                      border: OutlineInputBorder(),
                      helperText: 'The person responsible to make this happen',
                    ),
                    textInputAction: TextInputAction.next,
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              ExpansionTile(
                key: PageStorageKey('hazard3'),
                title: Text(
                  'Heat',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                children: [
                  Text(
                    'Probability',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.black12,
                      ),
                      child: DropdownButton<String>(
                          value: dropdownValue7,
                          elevation: 16,
                          underline: Container(
                            height: 2,
                          ),
                          items: <String>[
                            'A - Common or repeating',
                            'B - Known to occur',
                            'C - Could occur',
                            'D - Not likely to happen',
                            'E - Practically impossible',
                            'Not applicable',
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String newValue) {
                            HazardsDB.insert('installation_form_hazards', {
                              'hazardId': _intFormId+'-hazard3',
                              'formId': _intFormId,
                              'hazardName': 'hazard3',
                              'probability': newValue,
                              'consequence': _hazard3.consequence,
                              'risk': _hazard3.risk,
                              'controlMeasure': _hazard3.controlMeasure,
                              'person': _hazard3.person,
                              'status': _hazard3.status,
                            });
                            setState(() {
                              _hazard3 = Hazards(
                                formId: _intFormId,
                                hazardName: 'hazard3',
                                probability: newValue,
                                consequence: _hazard3.consequence,
                                risk: _hazard3.risk,
                                controlMeasure: _hazard3.controlMeasure,
                                person: _hazard3.person,
                                status: _hazard3.status,
                              );
                              dropdownValue7 = newValue;
                            });
                          })),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    'Consequence',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.black12,
                      ),
                      child: DropdownButton<String>(
                          value: dropdownValue8,
                          elevation: 16,
                          underline: Container(
                            height: 2,
                          ),
                          items: <String>[
                            '1 - Fatal or permanent serious injury',
                            '2 - Lost time injury or illness',
                            '3 - Medical treatment required',
                            '4 - First aid treatment',
                            '5 - Incident report only',
                            'Not applicable',
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String newValue) {
                            HazardsDB.insert('installation_form_hazards', {
                              'hazardId': _intFormId+'-hazard3',
                              'formId': _intFormId,
                              'hazardName': 'hazard3',
                              'probability': _hazard3.probability,
                              'consequence': newValue,
                              'risk': _hazard3.risk,
                              'controlMeasure': _hazard3.controlMeasure,
                              'person': _hazard3.person,
                              'status': _hazard3.status,
                            });
                            setState(() {
                              _hazard3 = Hazards(
                                formId: _intFormId,
                                hazardName: 'hazard3',
                                probability: _hazard3.probability,
                                consequence: newValue,
                                risk: _hazard3.risk,
                                controlMeasure: _hazard3.controlMeasure,
                                person: _hazard3.person,
                                status: _hazard3.status,
                              );
                              dropdownValue8 = newValue;
                            });
                          })),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    'Risk',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Container(
                      width: double.infinity,
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.black12,
                      ),
                      child: DropdownButton<String>(
                          value: dropdownValue9,
                          elevation: 16,
                          underline: Container(
                            height: 2,
                          ),
                          items: <String>[
                            'High',
                            'Significant',
                            'Moderate',
                            'Low',
                            'Not applicable',
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String newValue) {
                            HazardsDB.insert('installation_form_hazards', {
                              'hazardId': _intFormId+'-hazard3',
                              'formId': _intFormId,
                              'hazardName': 'hazard3',
                              'probability': _hazard3.probability,
                              'consequence': _hazard3.consequence,
                              'risk': newValue,
                              'controlMeasure': _hazard3.controlMeasure,
                              'person': _hazard3.person,
                              'status': _hazard3.status,
                            });
                            setState(() {
                              _hazard3 = Hazards(
                                formId: _intFormId,
                                hazardName: 'hazard3',
                                probability: _hazard3.probability,
                                consequence: _hazard3.consequence,
                                risk: newValue,
                                controlMeasure: _hazard3.controlMeasure,
                                person: _hazard3.person,
                                status: _hazard3.status,
                              );
                              dropdownValue9 = newValue;
                            });
                          })),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    key: PageStorageKey('controlMeasure3'),
                    initialValue: _hazard3.controlMeasure,
                    onChanged: (value) {
                      HazardsDB.insert('installation_form_hazards', {
                        'hazardId': _intFormId+'-hazard3',
                        'formId': _intFormId,
                        'hazardName': 'hazard3',
                        'probability': _hazard3.probability,
                        'consequence': _hazard3.consequence,
                        'risk': _hazard3.risk,
                        'controlMeasure': value,
                        'person': _hazard3.person,
                        'status': _hazard3.status,
                      });
                      setState(() {
                        _hazard3 = Hazards(
                          formId: _intFormId,
                          hazardName: 'hazard3',
                          probability: _hazard3.probability,
                          consequence: _hazard3.consequence,
                          risk: _hazard3.risk,
                          controlMeasure: value,
                          person: _hazard3.person,
                          status: _hazard3.status,
                        );
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'Control Measure',
                      contentPadding: EdgeInsets.all(3),
                      border: OutlineInputBorder(),
                      helperText:
                          'Eliminate, Isolate, minimise to a safe level (state how)',
                    ),
                    textInputAction: TextInputAction.next,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    key: PageStorageKey('person3'),
                    initialValue: _hazard3.person,
                    onChanged: (value) {
                      HazardsDB.insert('installation_form_hazards', {
                        'hazardId': _intFormId+'-hazard3',
                        'formId': _intFormId,
                        'hazardName': 'hazard3',
                        'probability': _hazard3.probability,
                        'consequence': _hazard3.consequence,
                        'risk': _hazard3.risk,
                        'controlMeasure': _hazard3.controlMeasure,
                        'person': value,
                        'status': _hazard3.status,
                      });
                      setState(() {
                        _hazard3 = Hazards(
                          formId: _intFormId,
                          hazardName: 'hazard3',
                          probability: _hazard3.probability,
                          consequence: _hazard3.consequence,
                          risk: _hazard3.risk,
                          controlMeasure: _hazard3.controlMeasure,
                          person: value,
                          status: _hazard3.status,
                        );
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'Person',
                      contentPadding: EdgeInsets.all(3),
                      border: OutlineInputBorder(),
                      helperText: 'The person responsible to make this happen',
                    ),
                    textInputAction: TextInputAction.next,
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              ExpansionTile(
                key: PageStorageKey('hazard4'),
                title: Text(
                  'Falls from Height',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                children: [
                  Text(
                    'Probability',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.black12,
                      ),
                      child: DropdownButton<String>(
                          value: dropdownValue10,
                          elevation: 16,
                          underline: Container(
                            height: 2,
                          ),
                          items: <String>[
                            'A - Common or repeating',
                            'B - Known to occur',
                            'C - Could occur',
                            'D - Not likely to happen',
                            'E - Practically impossible',
                            'Not applicable',
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String newValue) {
                            HazardsDB.insert('installation_form_hazards', {
                              'hazardId': _intFormId+'-hazard4',
                              'formId': _intFormId,
                              'hazardName': 'hazard4',
                              'probability': newValue,
                              'consequence': _hazard4.consequence,
                              'risk': _hazard4.risk,
                              'controlMeasure': _hazard4.controlMeasure,
                              'person': _hazard4.person,
                              'status': _hazard4.status,
                            });
                            setState(() {
                              _hazard4 = Hazards(
                                formId: _intFormId,
                                hazardName: 'hazard4',
                                probability: newValue,
                                consequence: _hazard4.consequence,
                                risk: _hazard4.risk,
                                controlMeasure: _hazard4.controlMeasure,
                                person: _hazard4.person,
                                status: _hazard4.status,
                              );
                              dropdownValue10 = newValue;
                            });
                          })),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    'Consequence',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.black12,
                      ),
                      child: DropdownButton<String>(
                          value: dropdownValue11,
                          elevation: 16,
                          underline: Container(
                            height: 2,
                          ),
                          items: <String>[
                            '1 - Fatal or permanent serious injury',
                            '2 - Lost time injury or illness',
                            '3 - Medical treatment required',
                            '4 - First aid treatment',
                            '5 - Incident report only',
                            'Not applicable',
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String newValue) {
                            HazardsDB.insert('installation_form_hazards', {
                              'hazardId': _intFormId+'-hazard4',
                              'formId': _intFormId,
                              'hazardName': 'hazard4',
                              'probability': _hazard4.probability,
                              'consequence': newValue,
                              'risk': _hazard4.risk,
                              'controlMeasure': _hazard4.controlMeasure,
                              'person': _hazard4.person,
                              'status': _hazard4.status,
                            });
                            setState(() {
                              _hazard4 = Hazards(
                                formId: _intFormId,
                                hazardName: 'hazard4',
                                probability: _hazard4.probability,
                                consequence: newValue,
                                risk: _hazard4.risk,
                                controlMeasure: _hazard4.controlMeasure,
                                person: _hazard4.person,
                                status: _hazard4.status,
                              );
                              dropdownValue11 = newValue;
                            });
                          })),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    'Risk',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Container(
                      width: double.infinity,
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.black12,
                      ),
                      child: DropdownButton<String>(
                          value: dropdownValue12,
                          elevation: 16,
                          underline: Container(
                            height: 2,
                          ),
                          items: <String>[
                            'High',
                            'Significant',
                            'Moderate',
                            'Low',
                            'Not applicable',
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String newValue) {
                            HazardsDB.insert('installation_form_hazards', {
                              'hazardId': _intFormId+'-hazard4',
                              'formId': _intFormId,
                              'hazardName': 'hazard4',
                              'probability': _hazard4.probability,
                              'consequence': _hazard4.consequence,
                              'risk': newValue,
                              'controlMeasure': _hazard4.controlMeasure,
                              'person': _hazard4.person,
                              'status': '_hazard4.status',
                            });
                            setState(() {
                              _hazard4 = Hazards(
                                formId: _intFormId,
                                hazardName: 'hazard4',
                                probability: _hazard4.probability,
                                consequence: _hazard4.consequence,
                                risk: newValue,
                                controlMeasure: _hazard4.controlMeasure,
                                person: _hazard4.person,
                                status: _hazard4.status,
                              );
                              dropdownValue12 = newValue;
                            });
                          })),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    key: PageStorageKey('controlMeasure4'),
                    initialValue: _hazard4.controlMeasure,
                    onChanged: (value) {
                      HazardsDB.insert('installation_form_hazards', {
                        'hazardId': _intFormId+'-hazard4',
                        'formId': _intFormId,
                        'hazardName': 'hazard4',
                        'probability': _hazard4.probability,
                        'consequence': _hazard4.consequence,
                        'risk': _hazard4.risk,
                        'controlMeasure': value,
                        'person': _hazard4.person,
                        'status': _hazard4.status,
                      });
                      setState(() {
                        _hazard4 = Hazards(
                          formId: _intFormId,
                          hazardName: 'hazard4',
                          probability: _hazard4.probability,
                          consequence: _hazard4.consequence,
                          risk: _hazard4.risk,
                          controlMeasure: value,
                          person: _hazard4.person,
                          status: _hazard4.status,
                        );
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'Control Measure',
                      contentPadding: EdgeInsets.all(3),
                      border: OutlineInputBorder(),
                      helperText:
                          'Eliminate, Isolate, minimise to a safe level (state how)',
                    ),
                    textInputAction: TextInputAction.next,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    key: PageStorageKey('person4'),
                    initialValue: _hazard4.person,
                    onChanged: (value) {
                      HazardsDB.insert('installation_form_hazards', {
                        'hazardId': _intFormId+'-hazard4',
                        'formId': _intFormId,
                        'hazardName': 'hazard4',
                        'probability': _hazard4.probability,
                        'consequence': _hazard4.consequence,
                        'risk': _hazard4.risk,
                        'controlMeasure': _hazard4.controlMeasure,
                        'person': value,
                        'status': _hazard4.status,
                      });
                      setState(() {
                        _hazard4 = Hazards(
                          formId: _intFormId,
                          hazardName: 'hazard4',
                          probability: _hazard4.probability,
                          consequence: _hazard4.consequence,
                          risk: _hazard4.risk,
                          controlMeasure: _hazard4.controlMeasure,
                          person: value,
                          status: _hazard4.status,
                        );
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'Person',
                      contentPadding: EdgeInsets.all(3),
                      border: OutlineInputBorder(),
                      helperText: 'The person responsible to make this happen',
                    ),
                    textInputAction: TextInputAction.next,
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              ExpansionTile(
                key: PageStorageKey('hazard5'),
                title: Text(
                  'Asbestos (lagging or loose fill insulation)',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                children: [
                  Text(
                    'Probability',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.black12,
                      ),
                      child: DropdownButton<String>(
                          value: dropdownValue13,
                          elevation: 16,
                          underline: Container(
                            height: 2,
                          ),
                          items: <String>[
                            'A - Common or repeating',
                            'B - Known to occur',
                            'C - Could occur',
                            'D - Not likely to happen',
                            'E - Practically impossible',
                            'Not applicable',
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String newValue) {
                            HazardsDB.insert('installation_form_hazards', {
                              'hazardId': _intFormId+'-hazard5',
                              'formId': _intFormId,
                              'hazardName': 'hazard5',
                              'probability': newValue,
                              'consequence': _hazard5.consequence,
                              'risk': _hazard5.risk,
                              'controlMeasure': _hazard5.controlMeasure,
                              'person': _hazard5.person,
                              'status': _hazard5.status,
                            });
                            setState(() {
                              _hazard5 = Hazards(
                                formId: _intFormId,
                                hazardName: 'hazard5',
                                probability: newValue,
                                consequence: _hazard5.consequence,
                                risk: _hazard5.risk,
                                controlMeasure: _hazard5.controlMeasure,
                                person: _hazard5.person,
                                status: _hazard5.status,
                              );
                              dropdownValue13 = newValue;
                            });
                          })),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    'Consequence',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.black12,
                      ),
                      child: DropdownButton<String>(
                          value: dropdownValue14,
                          elevation: 16,
                          underline: Container(
                            height: 2,
                          ),
                          items: <String>[
                            '1 - Fatal or permanent serious injury',
                            '2 - Lost time injury or illness',
                            '3 - Medical treatment required',
                            '4 - First aid treatment',
                            '5 - Incident report only',
                            'Not applicable',
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String newValue) {
                            HazardsDB.insert('installation_form_hazards', {
                              'hazardId': _intFormId+'-hazard5',
                              'formId': _intFormId,
                              'hazardName': 'hazard5',
                              'probability': _hazard5.probability,
                              'consequence': newValue,
                              'risk': _hazard5.risk,
                              'controlMeasure': _hazard5.controlMeasure,
                              'person': _hazard5.person,
                              'status': _hazard5.status,
                            });
                            setState(() {
                              _hazard5 = Hazards(
                                formId: _intFormId,
                                hazardName: 'hazard5',
                                probability: _hazard5.probability,
                                consequence: newValue,
                                risk: _hazard5.risk,
                                controlMeasure: _hazard5.controlMeasure,
                                person: _hazard5.person,
                                status: _hazard5.status,
                              );
                              dropdownValue14 = newValue;
                            });
                          })),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    'Risk',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Container(
                      width: double.infinity,
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.black12,
                      ),
                      child: DropdownButton<String>(
                          value: dropdownValue15,
                          elevation: 16,
                          underline: Container(
                            height: 2,
                          ),
                          items: <String>[
                            'High',
                            'Significant',
                            'Moderate',
                            'Low',
                            'Not applicable',
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String newValue) {
                            HazardsDB.insert('installation_form_hazards', {
                              'hazardId': _intFormId+'-hazard5',
                              'formId': _intFormId,
                              'hazardName': 'hazard5',
                              'probability': _hazard5.probability,
                              'consequence': _hazard5.consequence,
                              'risk': newValue,
                              'controlMeasure': _hazard5.controlMeasure,
                              'person': _hazard5.person,
                              'status': _hazard5.status,
                            });
                            setState(() {
                              _hazard5 = Hazards(
                                formId: _intFormId,
                                hazardName: 'hazard5',
                                probability: _hazard5.probability,
                                consequence: _hazard5.consequence,
                                risk: newValue,
                                controlMeasure: _hazard5.controlMeasure,
                                person: _hazard5.person,
                                status: _hazard5.status,
                              );
                              dropdownValue15 = newValue;
                            });
                          })),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    key: PageStorageKey('controlMeasure5'),
                    initialValue: _hazard5.controlMeasure,
                    onChanged: (value) {
                      HazardsDB.insert('installation_form_hazards', {
                        'hazardId': _intFormId+'-hazard5',
                        'formId': _intFormId,
                        'hazardName': 'hazard5',
                        'probability': _hazard5.probability,
                        'consequence': _hazard5.consequence,
                        'risk': _hazard5.risk,
                        'controlMeasure': value,
                        'person': _hazard5.person,
                        'status': _hazard5.status,
                      });
                      setState(() {
                        _hazard5 = Hazards(
                          formId: _intFormId,
                          hazardName: 'hazard5',
                          probability: _hazard5.probability,
                          consequence: _hazard5.consequence,
                          risk: _hazard5.risk,
                          controlMeasure: value,
                          person: _hazard5.person,
                          status: _hazard5.status,
                        );
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'Control Measure',
                      contentPadding: EdgeInsets.all(3),
                      border: OutlineInputBorder(),
                      helperText:
                          'Eliminate, Isolate, minimise to a safe level (state how)',
                    ),
                    textInputAction: TextInputAction.next,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    key: PageStorageKey('person5'),
                    initialValue: _hazard5.person,
                    onChanged: (value) {
                      HazardsDB.insert('installation_form_hazards', {
                        'hazardId': _intFormId+'-hazard5',
                        'formId': _intFormId,
                        'hazardName': 'hazard5',
                        'probability': _hazard5.probability,
                        'consequence': _hazard5.consequence,
                        'risk': _hazard5.risk,
                        'controlMeasure': _hazard5.controlMeasure,
                        'person': value,
                        'status': _hazard5.status,
                      });
                      setState(() {
                        _hazard5 = Hazards(
                          formId: _intFormId,
                          hazardName: 'hazard5',
                          probability: _hazard5.probability,
                          consequence: _hazard5.consequence,
                          risk: _hazard5.risk,
                          controlMeasure: _hazard5.controlMeasure,
                          person: value,
                          status: _hazard5.status,
                        );
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'Person',
                      contentPadding: EdgeInsets.all(3),
                      border: OutlineInputBorder(),
                      helperText: 'The person responsible to make this happen',
                    ),
                    textInputAction: TextInputAction.next,
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                ],
              ),
              SizedBox(
                height: 15.0,
              ),
              const Divider(
                height: 20,
                thickness: 5,
                indent: 0,
                endIndent: 0,
              ),
              Container(
                width: double.infinity,
                child:Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => FinalSubmission()),
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
                ),),
            ],
          ),)
        ));
  }
}
