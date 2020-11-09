import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/entries.dart';
import './entry_details.dart';

class EntryList extends StatefulWidget {
  @override
  _EntryListState createState() => _EntryListState();
}

class _EntryListState extends State<EntryList> {
  final List<Entry> entries = [
    Entry(id: '11', orderNumber: '0001', builderName: 'Oztek Construction Pty Ltd', date: DateTime.utc(2019, 5, 5)),
    Entry(id: '10', orderNumber: '0001', builderName: 'Oztek Construction Pty Ltd', date: DateTime.utc(2019, 5, 5)),
    Entry(id: '9', orderNumber: '0001', builderName: 'Oztek Construction Pty Ltd', date: DateTime.utc(2019, 5, 5)),
    Entry(id: '8', orderNumber: '0001', builderName: 'Oztek Construction Pty Ltd', date: DateTime.utc(2019, 5, 5)),
    Entry(id: '7', orderNumber: '0001', builderName: 'Oztek Construction Pty Ltd', date: DateTime.utc(2019, 5, 5)),
    Entry(id: '6', orderNumber: '0001', builderName: 'Oztek Construction Pty Ltd', date: DateTime.utc(2019, 5, 5)),
    Entry(id: '5', orderNumber: '0001', builderName: 'Oztek Construction Pty Ltd', date: DateTime.utc(2019, 5, 5)),
    Entry(id: '4', orderNumber: '0001', builderName: 'Oztek Construction Pty Ltd', date: DateTime.utc(2019, 5, 5)),
    Entry(id: '3', orderNumber: '0001', builderName: 'Oztek Construction Pty Ltd', date: DateTime.utc(2019, 5, 5)),
    Entry(id: '2', orderNumber: '0002', builderName: 'SV Homes', date: DateTime.now()),
    Entry(id: '1', orderNumber: '0001', builderName: 'Oztek Construction Pty Ltd', date: DateTime.utc(2019, 5, 5)),
  ];

  @override
  Widget build(BuildContext context) {
    return Container (
        height: 570,
        child: ListView.builder(
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
                        Text(DateFormat('MM/dd/yy').format(entries[index].date), style: TextStyle(fontWeight: FontWeight.bold)),
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
                          MaterialPageRoute(builder: (context) => EntryDetails(entries[index].id, entries[index].builderName, entries[index].orderNumber, DateFormat('MM/dd/yy').format(entries[index].date))),
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
