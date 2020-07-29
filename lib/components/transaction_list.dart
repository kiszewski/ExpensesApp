import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  final void Function(Transaction tr) _delete;

  TransactionList(this.transactions, this._delete);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(builder: (ctx, constraints) {
            return Column(
              children: <Widget>[
                SizedBox(height: 20),
                Text(
                  'Nenhuma despesa listada',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                ),
                SizedBox(height: 20),
                Container(
                  height: constraints.maxHeight * 0.6,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                )
              ],
            );
          })
        : ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (ctx, index) {
              final tr = transactions[index];
              return Card(
                child: Row(
                  children: <Widget>[
                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      padding: EdgeInsets.all(5),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                            maxHeight: 35,
                            maxWidth: 75,
                            minHeight: 35,
                            minWidth: 75),
                        child: FittedBox(
                          child: Text(
                            'R\$ ${tr.value.toStringAsFixed(2)}',
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context).accentColor),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(tr.name,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              )),
                          SizedBox(
                            height: 5,
                          ),
                          Text(DateFormat('d MMM y').format(tr.date),
                              style: TextStyle(color: Colors.grey))
                        ],
                      ),
                    ),
                    IconButton(
                      color: Theme.of(context).primaryColor,
                      icon: Icon(Icons.delete_outline),
                      onPressed: () {
                        _delete(tr);
                      },
                    )
                  ],
                ),
              );
            },
          );
  }
}
