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
}
