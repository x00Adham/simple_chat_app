import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //* login with email and password
  Future<UserCredential> loginWithEmailPassword(
    String email,
    String password,
  ) async {
    final userCredential = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return userCredential;
  }

  //* register with email and password
  Future<UserCredential> signUpWithEmailPassword(
    String email,
    String password,
  ) async {
    final userCredential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    //* save user to database
    _firestore.collection("Users").doc(userCredential.user?.uid).set({
      "uid": userCredential.user?.uid,
      "email": email,
    });

    return userCredential;
  }

  //* logout
  Future<void> signOut() async {
    await _auth.signOut();
  }

  //* get current user
  User? getCurrentuser() {
    return _auth.currentUser;
  }
}
