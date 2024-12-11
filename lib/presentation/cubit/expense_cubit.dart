import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/expense_model.dart';
import '../../domain/entities/expense.dart';
import '../../domain/usecases/manage_expenses.dart';

class ExpenseCubit extends Cubit<List<ExpenseModel>> {
  final ManageExpenses manageExpenses;

  ExpenseCubit(this.manageExpenses) : super([]);

  // Fetch expenses from the use case
  Future<void> fetchExpenses() async {
    try {
      final expenses = await manageExpenses.getExpenses();
      emit(expenses); // Emit the updated expenses list
    } catch (e) {
      emit([]);  // In case of error, emit empty list or handle error state
    }
  }

  // Add expense using the manageExpenses use case
  Future<void> addExpense(Expense expense) async {
    try {
      // Convert Expense (domain layer) to ExpenseModel (data layer)
      final expenseModel = ExpenseModel(
        id: null,  // ID should be null, database will generate the ID
        description: expense.description,
        amount: expense.amount,
        date: expense.date,

      );

      // Call the use case to add the expense
      await manageExpenses.addExpense(expenseModel);  // Use the use case to add the expense
      fetchExpenses();  // Fetch updated expenses after adding
    } catch (e) {
      // Handle errors if necessary (could show a message to the user)
      print('Error adding expense: $e');
    }
  }

  // Update expense using the manageExpenses use case
  Future<void> updateExpense(Expense updatedExpense) async {
    try {
      // Convert updatedExpense (domain) to ExpenseModel (data layer)
      final updatedExpenseModel = ExpenseModel(
        id: updatedExpense.id,  // ID should already be available in domain model
        description: updatedExpense.description,
        amount: updatedExpense.amount,
        date: updatedExpense.date,

      );

      // Call the use case to update the expense
      await manageExpenses.updateExpense(updatedExpenseModel);  // Use the use case to update the expense

      // Fetch updated expenses list after update
      fetchExpenses();
    } catch (e) {
      // Handle errors if necessary
      print('Error updating expense: $e');
    }
  }

  // Delete expense using the manageExpenses use case
  Future<void> deleteExpense(int id) async {
    try {
      await manageExpenses.deleteExpense(id);
      fetchExpenses();  // Fetch updated expenses after deletion
    } catch (e) {
      // Handle errors if necessary
      print('Error deleting expense: $e');
    }
  }
}
