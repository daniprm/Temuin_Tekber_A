import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  // Collection reference
  final CollectionReference lostCollection =
      FirebaseFirestore.instance.collection('losts  ');

  // Future updateUserData(String itemName, String location, String d)
}
