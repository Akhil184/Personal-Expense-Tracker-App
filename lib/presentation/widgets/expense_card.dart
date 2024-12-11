import 'package:flutter/material.dart';
import 'package:intl/intl.dart';  // Import intl package for date formatting

import '../../data/models/expense_model.dart';
import '../pages/expense_summary_page.dart';

class ExpenseCard extends StatelessWidget {
  final ExpenseModel expense;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  const ExpenseCard({
    required this.expense,
    required this.onDelete,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    // Format the DateTime object to a string
    final formattedDate = DateFormat('yyyy-MM-dd').format(expense.date);

    return GestureDetector(
        onTap: () {
      // When the card is tapped, navigate to the summary page
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ExpenseSummaryPage(), // Pass the expense data to the summary page
        ),
      );
    },

      child:Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: ListTile(
        title: Text(expense.description),
        subtitle: Text(formattedDate),  // Use the formatted date string here

        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.edit, color: Colors.blue),
              onPressed: onEdit,
            ),
            IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: onDelete,
            ),
          ],
        ),
        onTap: onEdit,
      ),
      ),
    );
  }
}
