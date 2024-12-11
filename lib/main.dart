import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'data/datasources/expense_local_data_source.dart';
import 'data/models/expense_model.dart';
import 'presentation/pages/add_expense_page.dart';
import 'presentation/pages/edit_expense_page.dart';
import 'presentation/pages/expense_list_page.dart';
import 'presentation/pages/expense_summary_page.dart';
import 'presentation/cubit/expense_cubit.dart';
import 'domain/usecases/manage_expenses.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    _initializeNotifications();

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ExpenseCubit(ManageExpenses(ExpenseLocalDataSource())),
        ),
      ],
      child: MaterialApp(
        title: 'Expense Tracker',
        theme: ThemeData(primarySwatch: Colors.blue),
        initialRoute: '/',
        routes: {
          '/': (context) => ExpenseListPage(),
          '/addExpense': (context) => AddExpensePage(),
          '/editExpense': (context) => EditExpensePage(
            expense: ModalRoute.of(context)!.settings.arguments as ExpenseModel,
          ),
          '/summaryPage': (context) => ExpenseSummaryPage(
            expense: ModalRoute.of(context)!.settings.arguments as ExpenseModel,
          ),
        },
      ),
    );
  }

  void _initializeNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
    InitializationSettings(android: initializationSettingsAndroid);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }
}
