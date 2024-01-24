import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/entries_model.dart';

class FirebaseService {
  static final CollectionReference entriesCollection =
      FirebaseFirestore.instance.collection('Entries');

  static addEntry(EntryModel entry) async {
    try {
      await entriesCollection.add({
        'title': entry.title,
        'description': entry.description,
        'date': entry.date,
        'time': entry.time,
        'entryType': entry.entryType,
        'amount': double.parse(entry.amount),
      });
      print('entry added successfully!');
    } catch (e) {
      print('Error adding entry: $e');
    }
  }

  static Future<List<EntryModel>> getEntries() async {
    try {
      QuerySnapshot querySnapshot = await entriesCollection.get();
      return querySnapshot.docs
          .map((doc) => EntryModel.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print('Error getting entries: $e');
      return [];
    }
  }

  static Future<Map<String, double>> getTotalAmounts() async {
  try {
    QuerySnapshot querySnapshot = await entriesCollection.get();

    List<EntryModel> entryModels = querySnapshot.docs
        .map((doc) => EntryModel.fromMap(doc.data() as Map<String, dynamic>))
        .toList();

    double totalIncome = entryModels
        .where((entry) => entry.entryType == 'Income')
        .map((entry) => entry.amount)
        .fold(0.0, (sum, amount) => sum + amount);

    double totalExpense = entryModels
        .where((entry) => entry.entryType == 'Expense')
        .map((entry) => entry.amount)
        .fold(0.0, (sum, amount) => sum + amount);

    print("Total Income: $totalIncome");
    print("Total Expense: $totalExpense");

    return {
      'Income': totalIncome,
      'Expense': totalExpense,
    };
  } catch (e) {
    print('Error getting total amounts: $e');
    return {
      'Income': 0.0,
      'Expense': 0.0,
    };
  }
}

}
