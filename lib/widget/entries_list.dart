import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/InstallationFormEntry.dart';
import '../models/entries.dart';
import '../install_form.dart';
import './entry_details.dart';


class EntryList extends StatefulWidget {
  @override
  _EntryListState createState() => _EntryListState();
}

Future<dynamic> fetchFormEntries() async{
  print("FETCHED DATA");
  var dataList = await InstallationFormEntryDB.getData('installation_form_entry');
  print('CHECK IF EMPTY');
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

class _EntryListState extends State<EntryList> {
  var entries = [];
  var getEntry;
  var entryList = [];
  @override
  void initState() {
    super.initState();
  }
  void updateList() {
    fetchFormEntries().then((val) => setState(() {
      if(val.isEmpty){
        print('There are currently no entries.');
      }
      else {
        print(val);
        for(var i=0; i<val.length; i++){
          getEntry = Entry(
            orderNumber: val[i].orderNumber.toString(),
            builderName: checkifEmpty(val[i].builderName.toString()),
            orderDate: checkifEmpty(val[i].date.toString()),
            formId: checkifEmpty(val[i].formId.toString()),
          );
          entryList.add(getEntry);
        }
      }
      entries = entryList;
    }));
  }
  _EntryListState() {
    updateList();
  }

  @override
  Widget build(BuildContext context) {
    return Container (
        height: 570,
        child: entries.isEmpty ? Center(child: Text('There are currently no entries.')) :
        ListView.builder(
          itemCount: entries.length,
          itemBuilder: (ctx, index) {
            return Card(
              elevation: 5,
              margin: EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 5,
              ),
              child: Row(children: <Widget>[
                SizedBox(
                  width: 395,
                  child: ListTile(
                    leading: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(entries[index].orderDate, style: TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                    title: Text(entries[index].builderName,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text('Order Number: ${entries[index].orderNumber}'),
                    trailing: IconButton(
                      icon: Icon(Icons.more_horiz),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => EntryDetails(entries[index].formId, entries[index].builderName, entries[index].orderNumber, entries[index].orderDate)),
                        );
                      },
                    ),
                  ),
                )
              ],),
            );
          },
        )
    );
  }
}
