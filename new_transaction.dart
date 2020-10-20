import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransactoion extends StatefulWidget {
  final Function addTx;

  NewTransactoion(this.addTx);

  @override
  _NewTransactoionState createState() => _NewTransactoionState();
}

class _NewTransactoionState extends State<NewTransactoion> {
  final _titleController = TextEditingController();

  final _amountcontroller = TextEditingController();
  DateTime _selectedDate;

  void _submitData() {
    if (_amountcontroller.text.isEmpty) {
      return;
    }
    final enterendTitle = _titleController.text;
    final enteredeAmount = double.parse(_amountcontroller.text);
    if (enterendTitle.isEmpty || enteredeAmount <= 0 || _selectedDate == null) {
      return;
    }
    widget.addTx(
      enterendTitle,
      enteredeAmount,
      _selectedDate,
    );
    Navigator.of(context).pop();
  }

  void _presentdaepicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
    print('...');
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: _titleController,
              //onChanged: (value) {
              //  titleInput = value;
              //},
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: _amountcontroller,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => _submitData,
              //onChanged: (value) => amountInput = value,
            ),
            Container(
              height: 70,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      _selectedDate == null
                          ? 'No date chosen!'
                          : 'Picked date: ${DateFormat.yMd().format(_selectedDate)}',
                    ),
                  ),
                  FlatButton(
                    textColor: Colors.indigo,
                    child: Text(
                      'Choose Date',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    onPressed: _presentdaepicker,
                  ),
                ],
              ),
            ),
            RaisedButton(
              child: Text('Add Transcation'),
              textColor: Colors.indigo,
              onPressed: _submitData,
            ),
          ],
        ),
      ),
    );
  }
}
