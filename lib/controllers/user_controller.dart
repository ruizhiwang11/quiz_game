import 'package:firebase_auth/firebase_auth.dart';

class UserController {
  final FirebaseAuth _firebaseAuth;

  UserController({FirebaseAuth ?firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  Future<void> signInWithEmail(String email, String password) {
    return _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  Future<UserCredential> signUpWithEmail(String email, String password) async {
    print(_firebaseAuth);
    return await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  Future<void> signOut() async {
    return await _firebaseAuth.signOut();
  }

  Future<void> resetAccount(String email) async {
    return await _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  Future<bool> isSignedIn() async {
    final currentUser = _firebaseAuth.currentUser!;
    return currentUser != null;
  }

  Future<String> getUser() async {
    return (await _firebaseAuth.currentUser!).uid;
  }
}