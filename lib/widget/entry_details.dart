import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../models/PopUpEntryList.dart';

class EntryDetails extends StatelessWidget {
  final String id;
  final String title;
  final String orderNum;
  final String date;

  EntryDetails(this.id, this.title, this.orderNum, this.date);

  void choiceAction(String choice) {
    if (choice == PopUpEntryList.Edit) {
      print("Edit");
    } else if (choice == PopUpEntryList.Delete) {
      print("Delete");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${title}", style: TextStyle(color: Colors.white)),
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: choiceAction,
            itemBuilder: (BuildContext context) {
              return PopUpEntryList.choices.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            width: double.infinity,
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
              child: Text(
                '${title}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Row(
            children: [
              SizedBox(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'Order #: ${orderNum}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
              SizedBox(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 30),
                  child: Text(
                    'Date #: ${date}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
