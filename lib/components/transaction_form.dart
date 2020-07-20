import 'package:flutter/material.dart';

class TransactionForm extends StatelessWidget {
  // Temporarios:
  final titleController = TextEditingController();
  final valueController = TextEditingController();
  final void Function({String name, double value}) saveForm;

  TransactionForm(this.saveForm);

  _submitForm() {
    final title = titleController.text;
    final value = double.tryParse(valueController.text) ?? 0.0;

    if(title.isEmpty || value <= 0) {
      return;
    }
    saveForm(name: title, value: value);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          TextField(
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
                color: Colors.deepOrangeAccent[100],
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
