import 'package:flutter/foundation.dart';

class Transaction {
  String id;
  String title;
  double amount;
  DateTime date;

  Transaction(
      {@required this.id,
      @required this.amount,
      @required this.date,
      @required this.title});
}
