import 'package:cloud_firestore/cloud_firestore.dart';

class EntriesModel {
  final String title;
  final String description;
  final DateTime date;
  final String time;
  final String transactionType;
  final double amount;

  EntriesModel({
    required this.title,
    required this.description,
    required this.date,
    required this.time,
    required this.transactionType,
    required this.amount,
  });

  factory EntriesModel.fromMap(Map<String, dynamic> map) {
    return EntriesModel(
      title: map['title'],
      description: map['description'],
      date: (map['date'] as Timestamp).toDate(),
      time: map['time'],
      transactionType: map['transactionType'],
      amount: map['amount'].toDouble(),
    );
  }
}
