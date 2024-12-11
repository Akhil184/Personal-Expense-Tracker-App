import 'package:intl/intl.dart';

class ExpenseModel {
  final int? id;
  final String description;
  final double amount;
  final DateTime date;


  ExpenseModel({
    this.id,
    required this.description,
    required this.amount,
    required this.date,

  });

  // Convert to Map for storage
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'description': description,
      'amount': amount,
      'date': DateFormat('yyyy-MM-dd').format(date),

    };
  }

  // Factory constructor for creating ExpenseModel from Map
  factory ExpenseModel.fromMap(Map<String, dynamic> map) {
    return ExpenseModel(
      id: map['id'],
      description: map['description'] ?? '',
      amount: map['amount'] != null ? map['amount'].toDouble() : 0.0,
      date: map['date'] != null
          ? DateFormat('yyyy-MM-dd').parse(map['date'])
          : DateTime.now(),
      
    );
  }
}
