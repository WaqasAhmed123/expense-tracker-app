// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import '../models/entries_model.dart';

class FirebaseService {
  static final CollectionReference entriesCollection =
      FirebaseFirestore.instance.collection('Entries');
      FirebaseDatabase database = FirebaseDatabase.instance;

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
}
