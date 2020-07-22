import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart({this.recentTransactions});

  List<Map<String, Object>> get groupedTransactions {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));

      double totalSpent = 0.0;
      if (recentTransactions.length != 0) {
        recentTransactions.forEach((tr) {
          bool sameDay =
              DateFormat.d().format(weekDay) == DateFormat.d().format(tr.date);
          bool sameMonth =
              DateFormat.M().format(weekDay) == DateFormat.M().format(tr.date);
          bool sameYear =
              DateFormat.y().format(weekDay) == DateFormat.y().format(tr.date);

          if (sameDay && sameMonth && sameYear) {
            totalSpent = totalSpent + tr.value;
          }
        });
      }

      return {
        'weekDay': DateFormat.E().format(weekDay)[0],
        'totalSpent': totalSpent,
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 5,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactions.map((tr) {
            return Column(
              children: <Widget>[
                Text(tr['weekDay']),
                Text(tr['totalSpent'].toString()),
              ],
            );
          }).toList(),
        ));
  }
}
