import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<String?> login(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      return e.toString();
    }

    return null;
  }

  Future<String?> getUserName() async {
    final user = _firebaseAuth.currentUser;
    return user?.displayName;
  }

  Future<String> getEmail() async {
    final user = FirebaseAuth.instance.currentUser;
    return user?.email ?? "";
  }

  Future<String?> updateUserName(String name) async {
    _firebaseAuth.currentUser?.updateDisplayName(name);
    return getUserName();
  }

}