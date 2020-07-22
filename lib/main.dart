import 'components/transaction_form.dart';
import 'components/transaction_list.dart';
import 'components/chart.dart';
import 'package:flutter/material.dart';
import 'models/transaction.dart';

void main() {
  runApp(ExpensesApp());
}

class ExpensesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
      theme: ThemeData(
        primarySwatch: Colors.red,
        accentColor: Colors.green[300],
        fontFamily: 'Epilogue',
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
            headline6: TextStyle(fontFamily: 'Ranchers', fontSize: 25)
          )
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transactions = [
    Transaction(
      id: 1,
      name: 'Antiga',
      value: 1000,
      date: DateTime.now().subtract(Duration(days: 45)),
    ),
    Transaction(
      id: 2,
      name: 'Tênis',
      value: 349.99,
      date: DateTime.now().subtract(Duration(days: 2)),
    ),
    Transaction(
      id: 3,
      name: 'Camiseta',
      value: 99.99,
      date: DateTime.now().subtract(Duration(days: 1)),
    ),
  ];

  List<Transaction> get _recentTransactions {
    return _transactions.where((tr) {
      return tr.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  _showTransactionModal(BuildContext context) {
    showModalBottomSheet(
        context: context, builder: (ctx) => TransactionForm(addTransaction));
  }

  addTransaction({String name, double value}) {
    var transaction = new Transaction(
        id: _transactions.length + 1,
        name: name,
        value: value,
        date: DateTime.now());

    setState(() {
      _transactions.add(transaction);
    });

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Despesas Pessoais'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.add), onPressed: () => _showTransactionModal(context))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Chart(recentTransactions: _recentTransactions),
            TransactionList(_transactions),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add, color: Colors.white,),
        onPressed: () => _showTransactionModal(context)),
    );
  }
}
