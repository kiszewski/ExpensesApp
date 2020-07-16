import 'package:flutter/material.dart';
import 'transaction_form.dart';
import 'transaction_list.dart';
import '../models/transaction.dart';

class TransactionUser extends StatefulWidget {
  @override
  _TransactionUserState createState() => _TransactionUserState();
}

class _TransactionUserState extends State<TransactionUser> {
  final _transactions = [
    Transaction(
      id: 1,
      name: 'Tênis',
      value: 349.99,
      date: DateTime.now(),
    ),
    Transaction(
      id: 2,
      name: 'Mochila',
      value: 99.90,
      date: DateTime.now(),
    ),
  ];

  saveForm({String name, String value}) {
    var transaction = new Transaction(
      id: _transactions.length + 1, 
      name: name, 
      value: double.parse(value), 
      date: DateTime.now());

    setState(() {
      _transactions.add(transaction);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TransactionList(_transactions),
        TransactionForm(saveForm)
      ],
    );
  }
}
