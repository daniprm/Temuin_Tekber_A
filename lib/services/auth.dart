import 'package:Temuin/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:Temuin/services/database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user obj based on firebase user
  UserModel? _userFromFirebaseUser(User? user) {
    return user != null ? UserModel(uid: user.uid) : null;
  }

  // auth change user stream
  Stream<UserModel?> get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  // sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      return null;
    }
  }

  // register with email and password
  Future<UserModel?> registerWithEmailAndPassword(
      String email, String password, String name, String phone) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      _auth.currentUser!.updateDisplayName(name);
      User? user = result.user;
      await user?.sendEmailVerification();
      await DatabaseService(uid: user!.uid).updateUserData(name, phone);

      return _userFromFirebaseUser(user);
    } catch (error) {
      return null;
    }
  }

  Future sendPassResetEmail(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      return 'Password reset link succesfully sent to your email, please check your email';
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (error) {
      return null;
    }
  }

  // Mendapatkan pengguna saat ini

  User? getCurrentUser() {
    return _auth.currentUser;
  }
}
