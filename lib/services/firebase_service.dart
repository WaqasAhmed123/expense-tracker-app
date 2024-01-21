import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/entries_model.dart';

class FirebaseService {
  final CollectionReference entriesCollection =
      FirebaseFirestore.instance.collection('Entries');

  Future<void> addEntry(EntriesModel entry) async {
    try {
      await entriesCollection.add({
        'title': entry.title,
        'description': entry.description,
        'date': entry.date,
        'time': entry.time,
        'entryType': entry.entryType,
        'amount': entry.amount,
      });
      print('entry added successfully!');
    } catch (e) {
      print('Error adding entry: $e');
    }
  }

  Future<List<EntriesModel>> getEntries() async {
    try {
      QuerySnapshot querySnapshot = await entriesCollection.get();
      return querySnapshot.docs
          .map(
              (doc) => EntriesModel.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print('Error getting entries: $e');
      return [];
    }
  }
}
