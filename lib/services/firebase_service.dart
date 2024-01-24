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

  static Future<double> getTotalAmountByEntryType(String entryType) async {
    try {
      QuerySnapshot querySnapshot = await entriesCollection
          .where('entryType', isEqualTo: entryType)
          .get();

      List<EntryModel> entryModels = querySnapshot.docs
          .map((doc) => EntryModel.fromMap(doc.data() as Map<String, dynamic>))
          .toList();

      double totalAmount = entryModels
          .map((entry) => int.parse(entry.amount))
          .fold(0.0, (sum, amount) => sum + amount);
      print("The amount is $totalAmount");
      return totalAmount;
    } catch (e) {
      print('Error getting total amount: $e');
      return 0.0;
    }
  }
}
