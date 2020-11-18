import 'package:flutter/foundation.dart';

class Entry {
  final String orderNumber;
  final String builderName;
  final String orderDate;
  final String formId;

  Entry({
    @required this.orderNumber,
    @required this.builderName,
    @required this.orderDate,
    @required this.formId
  });
}