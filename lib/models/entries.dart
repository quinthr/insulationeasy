import 'package:flutter/foundation.dart';

class Entry {
  final String id;
  final String orderNumber;
  final String builderName;
  final DateTime date;

  Entry({
    @required this.id,
    @required this.orderNumber,
    @required this.builderName,
    @required this.date
  });
}