import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'presentation/cubit/expense_cubit.dart';
import 'domain/usecases/manage_expenses.dart';
import 'data/datasources/expense_local_data_source.dart';
import 'presentation/pages/add_expense_page.dart';
import 'presentation/pages/edit_expense_page.dart';
import 'presentation/pages/expense_list_page.dart';
import 'presentation/pages/expense_summary_page.dart';
import 'utils/routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize notifications
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
        onGenerateRoute: AppRoutes.generateRoute,  // Use generateRoute here
      ),
    );
  }

  // Initialize local notifications
  void _initializeNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
    InitializationSettings(android: initializationSettingsAndroid);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }
}
