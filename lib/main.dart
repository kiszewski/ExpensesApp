import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(ExpensesApp());
}

class ExpensesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
   final _transactions = [
    Transaction(
      id: 't1',
      name: 'Tenis',
      value: 349.99,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      name: 'Mochila',
      value: 99.90,
      date: DateTime.now(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Despesas pessoais'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Card(
            elevation: 5,
            child: Text('Grafico'),
          ),
          Card(
            elevation: 5,
            child: Text('Transações'),
          ),
        ],
      ),
    );
  }
}
