import 'dart:math';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import '../models/transaction.dart';

class TransactionItem extends StatefulWidget {
  final Transaction transaction;
  final Function deleteTran;

  const TransactionItem({
    required Key key,
    required this.transaction,
    required this.deleteTran,
  }) : super(key: key);

  @override
  State<TransactionItem> createState() => _State();
}

class _State extends State<TransactionItem> {
  Color _bgColor = Colors.red;

  @override
  void initState() {
    const availableColors = [
      Colors.red,
      Colors.blue,
      Colors.green,
      Colors.orange
    ];
    _bgColor = availableColors[Random().nextInt(4)];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: _bgColor,
          radius: 30,
          child: Padding(
              padding: const EdgeInsets.all(5),
              child: FittedBox(
                  child: Text(
                      "₹ ${widget.transaction.amount.toStringAsFixed(2)}"))),
        ),
        title: Text(
          widget.transaction.title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        subtitle: Text(
          DateFormat.yMMMd().format(widget.transaction.dateTime),
          style: const TextStyle(
              fontWeight: FontWeight.bold, fontSize: 12, color: Colors.grey),
        ),
        trailing: IconButton(
            onPressed: () => widget.deleteTran(widget.transaction.id),
            icon: const Icon(Icons.delete),
            color: Colors.red),
      ),
    );
  }
}
