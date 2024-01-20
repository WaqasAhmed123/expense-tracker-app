import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  final CollectionReference entriesCollection =
      FirebaseFirestore.instance.collection('Entries');

  Future<void> addTransaction(Map<String, dynamic> transactionData) async {
    try {
      await entriesCollection.add(transactionData);
      print('Transaction added successfully!');
    } catch (e) {
      print('Error adding transaction: $e');
    }
  }

  Future<List<Map<String, dynamic>>> getTransactions() async {
    try {
      QuerySnapshot querySnapshot = await entriesCollection.get();
      return querySnapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
    } catch (e) {
      print('Error getting transactions: $e');
      return [];
    }
  }
}
