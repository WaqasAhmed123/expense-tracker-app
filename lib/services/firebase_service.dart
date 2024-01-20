import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/entries_model.dart';

class FirebaseService {
  final CollectionReference entriesCollection =
      FirebaseFirestore.instance.collection('Entries');

  
  Future<void> addTransaction(EntriesModel transaction) async {
    try {
      await entriesCollection.add({
        'title': transaction.title,
        'description': transaction.description,
        'date': transaction.date,
        'time': transaction.time,
        'transactionType': transaction.transactionType,
        'amount': transaction.amount,
      });
      print('Transaction added successfully!');
    } catch (e) {
      print('Error adding transaction: $e');
    }
  }

  Future<List<EntriesModel>> getTransactions() async {
  try {
    QuerySnapshot querySnapshot = await entriesCollection.get();
    return querySnapshot.docs
        .map((doc) => EntriesModel.fromMap(doc.data() as Map<String, dynamic>))
        .toList();
  } catch (e) {
    print('Error getting transactions: $e');
    return [];
  }
}

}
