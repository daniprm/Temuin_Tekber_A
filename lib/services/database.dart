import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class DatabaseService {
  final String? uid;
  DatabaseService({this.uid});
  // Collection reference
  final CollectionReference userDataCollection =
      FirebaseFirestore.instance.collection('userData');
  final CollectionReference lostItemsCollection =
      FirebaseFirestore.instance.collection('lostItems');

  Future updateUserData(String name, String phone) async {
    return await userDataCollection
        .doc(uid)
        .set({'name': name, 'phone': phone});
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getLostsCollection() {
    return FirebaseFirestore.instance
        .collection('lostItems')
        .where('isTaken', isEqualTo: false)
        .snapshots();
  }

  Future addLostItems(Map<String, Object> itemData) async {
    await lostItemsCollection.add(itemData);
  }

  Future<void> editItem(String itemId, String name, String location,
      String category, DateTime date) async {
    await lostItemsCollection.doc(itemId).update({
      'name': name,
      'location': location,
      'category': category,
      'date': date
    });
  }

  Future<bool?> takeLostItem(String itemId) async {
    try {
      final item =
          FirebaseFirestore.instance.collection('lostItems').doc(itemId);

      final itemSnapshot = await item.get();

      if (itemSnapshot.exists) {
        // Update dokumen
        await item.update({'isTaken': true, 'takenByid': uid});
        return true;
      } else {
        return null;
      }
    } catch (e) {
      return false;
    }
  }

  // // Get data
  // Stream<QuerySnapshot> get userData {
  //   return userDataCollection.snapshots();
  // }
}
