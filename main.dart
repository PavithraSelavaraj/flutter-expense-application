import 'package:expence/widgets/chart.dart';
import 'package:expence/widgets/new_transaction.dart';
import 'package:flutter/material.dart';
import 'package:expence/widgets/transaction_list.dart';
import './models/transaction.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Personal expenses",
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: MyhomePage(),
    );
  }
}

class MyhomePage extends StatefulWidget {
  //String titleInput;
  //String amountInput;
  @override
  _MyhomePageState createState() => _MyhomePageState();
}

class _MyhomePageState extends State<MyhomePage> {
  final List<Transaction> _usertransaction = [
    //Transaction(id: 't1', amount: 23.3, date: DateTime.now(), title: 'shoe'),
    //Transaction(id: 't2', amount: 30.3, date: DateTime.now(), title: 'book'),
  ];
  List<Transaction> get _recentTransaction {
    return _usertransaction.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addNewtransaction(
      String txtitle, double txamount, DateTime chosenDate) {
    final newtx = Transaction(
        title: txtitle,
        amount: txamount,
        date: chosenDate,
        id: DateTime.now().toString());
    setState(() {
      _usertransaction.add(newtx);
    });
  }

  void _StartaddNewtransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: NewTransactoion(_addNewtransaction),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  void _deleteTransaction(String id) {
    setState(() {
      _usertransaction.removeWhere((tx) {
        return tx.id == id;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Personal Expenses'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _StartaddNewtransaction(context),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            chart(_recentTransaction),
            Transactionlist(_usertransaction, _deleteTransaction),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _StartaddNewtransaction(context),
      ),
    );
  }
}
