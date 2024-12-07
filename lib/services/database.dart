import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({required this.uid});
  // Collection reference
  final CollectionReference userDataCollection =
      FirebaseFirestore.instance.collection('losts  ');

  Future updateUserData(String name, String phone) async {
    return await userDataCollection
        .doc(uid)
        .set({'name': name, 'phone': phone});
  }

  // Get data
  Stream<QuerySnapshot> get userData {
    return userDataCollection.snapshots();
  }
}
