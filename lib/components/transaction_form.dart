import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionForm extends StatefulWidget {
  final void Function({String name, double value, DateTime date})
      addTransaction;

  TransactionForm(this.addTransaction);

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final titleController = TextEditingController();
  final valueController = TextEditingController();
  DateTime date = DateTime.now();

  _submitForm() {
    final title = titleController.text;
    final value = double.tryParse(valueController.text) ?? 0.0;

    if (title.isEmpty || value <= 0) {
      return;
    }
    widget.addTransaction(
      name: title,
      value: value,
      date: date,
    );
  }

  _changeDate() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now().subtract(Duration(days: 365 * 5)),
            lastDate: DateTime.now().add(Duration(days: 90)))
        .then((value) {
      if (value != null) {
        setState(() => date = value);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextField(
            keyboardType: TextInputType.text,
            controller: titleController,
            onSubmitted: (_) => _submitForm(),
            decoration: InputDecoration(labelText: 'Despesa'),
            autofocus: true,
          ),
          TextField(
            controller: valueController,
            onSubmitted: (_) => _submitForm(),
            keyboardType: TextInputType.numberWithOptions(
                decimal: true), //essa função serve p dispositivos iOS
            decoration: InputDecoration(labelText: 'Valor (R\$)'),
          ),
          Container(
            child: Row(
              children: <Widget>[
                Expanded(
                    child: Text(
                        'Data selecionada: ${DateFormat('d MMM y').format(date)}')),
                FlatButton(
                  child: Text(
                    'Selecionar outra data',
                  ),
                  onPressed: _changeDate,
                  textColor: Theme.of(context).primaryColor,
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                RaisedButton(
                  color: Theme.of(context).primaryColor,
                  textColor: Theme.of(context).textTheme.button.color,
                  child: Text('Nova transação'),
                  onPressed: _submitForm,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
