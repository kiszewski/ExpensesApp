import 'package:flutter/material.dart';

class TransactionForm extends StatefulWidget {
  final void Function({String name, double value}) addTransaction;

  TransactionForm(this.addTransaction);

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final titleController = TextEditingController();

  final valueController = TextEditingController();

  _submitForm() {
    final title = titleController.text;
    final value = double.tryParse(valueController.text) ?? 0.0;

    if(title.isEmpty || value <= 0) {
      return;
    }
    widget.addTransaction(name: title, value: value);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          TextField(
            keyboardType: TextInputType.text,
            controller: titleController,
            onSubmitted: (_) => _submitForm(),
            decoration: InputDecoration(labelText: 'Despesa'),
          ),
          TextField(
            controller: valueController,
            onSubmitted: (_) => _submitForm(),
            keyboardType: TextInputType.numberWithOptions(decimal: true), //essa função serve p dispositivos iOS
            decoration: InputDecoration(labelText: 'Valor (R\$)'),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              FlatButton(
                textColor: Theme.of(context).primaryColor,
                child: Text('Nova transação'),
                onPressed: _submitForm,
              ),
            ],
          )
        ],
      ),
    );
  }
}
