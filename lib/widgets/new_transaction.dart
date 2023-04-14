import "package:flutter/material.dart";
import "package:intl/intl.dart";

class NewTransaction extends StatefulWidget {
  final Function addUserHandler;

  NewTransaction(this.addUserHandler, {super.key}) {
    // print("Constructor New Transaction widget::");
  }

  @override
  State<NewTransaction> createState() {
    // print("CreateState NewTransaction Widget");
    return _NewTransactionState();
  }
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  var _selectedDate;

  _NewTransactionState() {
    // print("Constructor New Transaction State");
  }

  @override
  void initState() {
    super.initState();
    // print("init State");
  }

  @override
  void didUpdateWidget(covariant NewTransaction oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    // print("did update widget");
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // print("dispose()");
  }

  void _submitData() {
    final enterTitled = _titleController.text;
    final enterAmount = double.parse(_amountController.text);

    if (enterTitled.isEmpty || enterAmount <= 0 || _selectedDate == null) {
      return;
    }

    widget.addUserHandler(enterTitled, enterAmount, _selectedDate);
    Navigator.of(context).pop();
    TextEditingController().clear();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1999),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextFormField(
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Title',
                  ),
                  keyboardType: TextInputType.text,
                  controller: _titleController,
                  onSaved: (_) => _submitData()),
              TextFormField(
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Amount',
                  ),
                  controller: _amountController,
                  keyboardType: TextInputType.name,
                  onSaved: (_) => _submitData()),
              SizedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(_selectedDate == null
                        ? "No Date Chosen"
                        : "Picked Date: ${DateFormat.yMd().format(_selectedDate)}"),
                    TextButton(
                      onPressed: () {
                        _presentDatePicker();
                      },
                      child: const Text("Choose Date"),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 15),
                child: ElevatedButton(
                  onPressed: () {
                    _submitData();
                  },
                  child: const Text(
                    "Add Transaction",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
