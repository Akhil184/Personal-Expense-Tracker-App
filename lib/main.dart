import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'presentation/cubit/expense_cubit.dart';
import 'domain/usecases/manage_expenses.dart';
import 'data/datasources/expense_local_data_source.dart';
import 'package:permission_handler/permission_handler.dart';
import 'utils/routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  // Initialize local notifications
  const AndroidInitializationSettings initializationSettingsAndroid =
  AndroidInitializationSettings('@mipmap/ic_launcher');
  const InitializationSettings initializationSettings =
  InitializationSettings(android: initializationSettingsAndroid);

  // Await for initialization before running the app
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  // Request notification permission
  await _requestNotificationPermission();

  runApp(MyApp(flutterLocalNotificationsPlugin: flutterLocalNotificationsPlugin));
}

// Request notification permission
Future<void> _requestNotificationPermission() async {
  PermissionStatus status = await Permission.notification.status;

  if (status.isDenied) {
    PermissionStatus newStatus = await Permission.notification.request();
    if (newStatus.isGranted) {
      print('Notification permission granted');
    } else {
      print('Notification permission denied');
    }
  } else if (status.isGranted) {
    print('Notification permission already granted');
  }
}

class MyApp extends StatelessWidget {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  MyApp({required this.flutterLocalNotificationsPlugin, super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ExpenseCubit(
            ManageExpenses(ExpenseLocalDataSource()),
            flutterLocalNotificationsPlugin,  // Pass the plugin here
          ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Expense Tracker',
        theme: ThemeData(primarySwatch: Colors.blue),
        initialRoute: '/',
        onGenerateRoute: AppRoutes.generateRoute, // Use generateRoute here
      ),
    );
  }
}
