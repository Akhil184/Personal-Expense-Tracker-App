import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/expense_model.dart';
import '../cubit/expense_cubit.dart';

class ExpenseSummaryPage extends StatefulWidget {
  @override
  _SummaryPageState createState() => _SummaryPageState();
}

class _SummaryPageState extends State<ExpenseSummaryPage> {
  bool isWeekly = true; // Toggle between weekly and monthly view

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expense Summary'),
      ),
      body: Column(
        children: [
          // Toggle for Weekly/Monthly View
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('View: '),
              Radio(
                value: true,
                groupValue: isWeekly,
                onChanged: (value) {
                  setState(() {
                    isWeekly = value!;
                  });
                },
              ),
              Text('Weekly'),
              Radio(
                value: false,
                groupValue: isWeekly,
                onChanged: (value) {
                  setState(() {
                    isWeekly = value!;
                  });
                },
              ),
              Text('Monthly'),
            ],
          ),
          Expanded(
            child: BlocBuilder<ExpenseCubit, List<ExpenseModel>>(
              builder: (context, expenses) {
                if (expenses.isEmpty) {
                  return Center(child: Text('No expenses available for summary.'));
                }

                // Call the function to get total expense summary based on the selected filter
                final totalExpense = _getTotalExpense(expenses);

                return ListView(
                  children: [
                    ListTile(
                      title: Text('Total Expenses'),
                      subtitle: Text(isWeekly
                          ? 'Total for this week'
                          : 'Total for this month'),
                      trailing: Text('\$${totalExpense.toStringAsFixed(2)}'),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Function to get total expenses for the week or month
  double _getTotalExpense(List<ExpenseModel> expenses) {
    final now = DateTime.now();
    double total = 0.0;

    for (var expense in expenses) {
      bool includeExpense = false;
      if (isWeekly) {
        final startOfWeek = now.subtract(Duration(days: now.weekday - 1)); // Start of the week
        if (expense.date.isAfter(startOfWeek)) {
          includeExpense = true;
        }
      } else {
        final startOfMonth = DateTime(now.year, now.month, 1); // Start of the month
        if (expense.date.isAfter(startOfMonth)) {
          includeExpense = true;
        }
      }

      if (includeExpense) {
        total += expense.amount;
      }
    }

    return total;
  }
}
