import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:expenses/models/transaction.dart';

class TransactionItem extends StatelessWidget {
  final Transaction tr;
  final void Function(Transaction tr) _deleteTransaction;


  TransactionItem(this.tr, this._deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            padding: const EdgeInsets.all(5),
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                  maxHeight: 35, maxWidth: 75, minHeight: 35, minWidth: 75),
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
                Text(
                  tr.name,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  DateFormat('d MMM y').format(tr.date),
                  style: TextStyle(color: Colors.grey),
                )
              ],
            ),
          ),
          IconButton(
            color: Theme.of(context).primaryColor,
            icon: const Icon(Icons.delete_outline),
            onPressed: () => _deleteTransaction(tr),
          )
        ],
      ),
    );
  }
}
