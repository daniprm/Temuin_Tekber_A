import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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

  Stream<QuerySnapshot<Map<String, dynamic>>> getAllLostsCollection() {
    return FirebaseFirestore.instance.collection('lostItems').snapshots();
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> getItemData(String itemId) {
    return FirebaseFirestore.instance
        .collection('lostItems')
        .doc(itemId)
        .snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getTakenCollection() {
    return FirebaseFirestore.instance
        .collection('lostItems')
        .where('isTaken', isEqualTo: true)
        .snapshots();
  }

  // Contoh implementasi fungsi stream untuk nama founder
  Stream<String?> getFounderNameStream(String founderId) {
    return FirebaseFirestore.instance
        .collection('userData')
        .doc(founderId)
        .snapshots()
        .map((snapshot) => snapshot.data()?['name'] as String?);
  }

  Future addLostItems(Map<String, Object?> itemData) async {
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

  Future<bool?> takeLostItem(String itemId, String takenBy) async {
    try {
      final item =
          FirebaseFirestore.instance.collection('lostItems').doc(itemId);

      final itemSnapshot = await item.get();

      if (itemSnapshot.exists) {
        // Update dokumen
        await item.update({
          'isTaken': true,
          'takenByid': uid,
          'takenBy': takenBy,
          'takenAt': DateTime.now()
        });
        return true;
      } else {
        return null;
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool?> restoreTakenItem(String itemId) async {
    try {
      final item =
          FirebaseFirestore.instance.collection('lostItems').doc(itemId);

      final itemSnapshot = await item.get();

      if (itemSnapshot.exists) {
        // Update dokumen
        await item
            .update({'isTaken': false, 'takenByid': null, 'takenBy': null});
        return true;
      } else {
        return null;
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool?> deleteItem(String itemId, String imgPath) async {
    try {
      final item =
          FirebaseFirestore.instance.collection('lostItems').doc(itemId);

      final itemSnapshot = await item.get();

      if (itemSnapshot.exists) {
        // Update dokumen
        await item.delete();
        await Supabase.instance.client.storage.from('images').remove([imgPath]);
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
