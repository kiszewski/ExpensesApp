import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String weekDay;
  final double totalSpent;
  final double percent;

  ChartBar({
    this.weekDay,
    this.totalSpent,
    this.percent,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text('R\$ $totalSpent'),
        SizedBox(
          height: 10,
        ),
        Container(
          height: 60,
          width: 10,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1),
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.grey[300]),
              ),
              FractionallySizedBox(
                heightFactor: percent,
                child: Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(5)),
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text(weekDay),
      ],
    );
  }
}
