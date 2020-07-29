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
        textTheme: ThemeData.light().textTheme.copyWith(
              button: TextStyle(
                color: Colors.white,
              ),
            ),
        appBarTheme: AppBarTheme(
            textTheme: ThemeData.light().textTheme.copyWith(
                  headline6: TextStyle(fontFamily: 'Ranchers', fontSize: 25),
                )),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transactions = [];
  bool _isLandscape = false;
  bool _showChart = false;

  List<Transaction> get _recentTransactions {
    return _transactions.where((tr) {
      return tr.date.isAfter(DateTime.now().subtract(Duration(days: 7))) &&
          tr.date.isBefore(DateTime.now());
    }).toList();
  }

  _showTransactionModal(BuildContext context) {
    showModalBottomSheet(
        context: context, builder: (ctx) => TransactionForm(_addTransaction));
  }

  _addTransaction({String name, double value, DateTime date}) {
    var transaction = new Transaction(
        id: _transactions.length + 1, name: name, value: value, date: date);

    setState(() {
      _transactions.add(transaction);
    });

    Navigator.of(context).pop();
  }

  _deleteTransaction(Transaction tr) {
    setState(() {
      _transactions.remove(tr);
    });
  }

  _switchChartList() {
    setState(() {
      _showChart = !_showChart;
    });
  }

  @override
  Widget build(BuildContext context) {
    _isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;

    final appBar = AppBar(
      title: Text(
        'Despesas Pessoais',
        style: TextStyle(fontSize: 25 * MediaQuery.of(context).textScaleFactor),
      ),
      leading: _isLandscape
          ? IconButton(
              icon: _showChart ? Icon(Icons.format_list_bulleted) : Icon(Icons.insert_chart),
              onPressed: _switchChartList,
            )
          : null,
      centerTitle: true,
      actions: <Widget>[
        IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _showTransactionModal(context)),
      ],
    );

    final availableHeight = MediaQuery.of(context).size.height -
        appBar.preferredSize.height -
        MediaQuery.of(context).padding.top;

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            if(!_isLandscape || _showChart)
            Container(
                height: _isLandscape ? availableHeight * 0.5 : availableHeight * 0.25,
                child: Chart(recentTransactions: _recentTransactions)),
            if(!_isLandscape || !_showChart)
            Container(
                height: _isLandscape ? availableHeight * 0.8 : availableHeight * 0.75,
                child: TransactionList(_transactions, _deleteTransaction)),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: () => _showTransactionModal(context)),
    );
  }
}
