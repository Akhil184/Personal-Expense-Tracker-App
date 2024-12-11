import 'package:flutter/material.dart';
import '../../data/models/expense_model.dart';
import 'package:intl/intl.dart';

class ExpenseSummaryPage extends StatelessWidget {
  final ExpenseModel expense;  // Pass ExpenseModel from the previous page

  ExpenseSummaryPage({required this.expense});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Expense Summary')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Description: ${expense.description}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('Amount: \$${expense.amount.toStringAsFixed(2)}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('Date: ${DateFormat.yMMMd().format(expense.date)}', style: TextStyle(fontSize: 18)),

          ],
        ),
      ),
    );
  }
}
