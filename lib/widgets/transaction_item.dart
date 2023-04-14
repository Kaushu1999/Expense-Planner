import "package:flutter/material.dart";
import "../models/transaction.dart";
import "dart:math";
import "package:intl/intl.dart";

class TransactionItem extends StatefulWidget {
  final Transaction transaction;
  final Function deleteHandler;

  const TransactionItem({
    super.key,
    required this.transaction,
    required this.deleteHandler,
  });

  @override
  State<TransactionItem> createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  var _bgcolor;

  @override
  void initState() {
    const availableColors = [
      Colors.red,
      Colors.blue,
      Colors.yellow,
      Colors.green
    ];

    _bgcolor = availableColors[Random().nextInt(4)];
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: ListTile(
          leading: CircleAvatar(
            radius: 30,
            backgroundColor: _bgcolor,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: FittedBox(
                child: Text(
                  '\$ ${widget.transaction.amount.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          title: Text(widget.transaction.title as String,
              style: Theme.of(context).textTheme.titleMedium),
          subtitle: Text(
            DateFormat.yMMMd().format(widget.transaction.date),
            style: const TextStyle(
              fontSize: 16,
              color: Colors.grey,
              fontWeight: FontWeight.bold,
            ),
          ),
          trailing: MediaQuery.of(context).size.width > 400
              ? TextButton.icon(
                  label: const Text('Delete',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    widget.deleteHandler(widget.transaction.id as String);
                  },
                )
              : IconButton(
                  onPressed: () {
                    widget.deleteHandler(widget.transaction.id as String);
                  },
                  icon: const Icon(Icons.delete),
                  color: Theme.of(context).colorScheme.error,
                )),
    );
  }
}
