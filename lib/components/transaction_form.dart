import 'package:flutter/material.dart';

class TransactionForm extends StatelessWidget {
  // Temporarios:
  final titleController = TextEditingController();
  final valueController = TextEditingController();
  final void Function({String name, String value}) saveForm;

  TransactionForm(this.saveForm);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          TextField(
            controller: titleController,
            decoration: InputDecoration(labelText: 'Despesa'),
          ),
          TextField(
            controller: valueController,
            decoration: InputDecoration(labelText: 'Valor (R\$)'),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              FlatButton(
                textColor: Colors.deepOrangeAccent[100],
                child: Text('Nova transação'),
                onPressed: () {
                  saveForm(
                    name: titleController.text,
                    value: valueController.text
                  );
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
