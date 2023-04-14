import 'package:flutter/material.dart';
import "../models/transaction.dart";
import "./transaction_item.dart";

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteHandler;

  const TransactionList(this.transactions, this.deleteHandler, {super.key});

  @override
  Widget build(BuildContext context) {
    // print("build () TransactionList");
    return SizedBox(
      child: ListView(
          children: transactions
              .map(
                (tx) => TransactionItem(
                    key: ValueKey(tx.id),
                    transaction: tx,
                    deleteHandler: deleteHandler),
              )
              .toList()),
    );
  }
}
