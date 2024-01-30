

class EntryModel {
  final String title;
  final String description;
  // final DateTime date;
  final String date;
  final String time;
  final String entryType;
  final dynamic amount;

  EntryModel({
    required this.title,
    required this.description,
    required this.date,
    required this.time,
    required this.entryType,
    required this.amount,
  });

  factory EntryModel.fromMap(Map<String, dynamic> map) {
    return EntryModel(
      title: map['title'],
      description: map['description'],
      date: map['date'],
      time: map['time'],
      entryType: map['entryType'],
      amount: map['amount'],
    );
  }
}
