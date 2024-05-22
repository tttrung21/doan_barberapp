import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doan_barberapp/shared/models/UserModel.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<void> guestMode() async {
    await _firebaseAuth.signInAnonymously();
  }

  Future<User?> signUp(
      {required String email, required String password}) async {
    try {
      UserCredential user = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      CollectionReference userRef = FirebaseFirestore.instance.collection('users');
      // DocumentSnapshot snapshotUser = await userRef.doc(_firebaseAuth.currentUser?.uid).get();
      if (user.user != null) {
        userRef.doc(_firebaseAuth.currentUser?.uid).set(UserModel(
                email: email,
                password: password,
                name: '',
                role: 'user',
                phoneNumber: '',
                uid: user.user?.uid,
                profilePic: '',
                dob: '')
            .toMap());
      }
      return user.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw Exception('Weak password');
      } else if (e.code == 'email-already-in-use') {
        throw Exception('Email has already been used');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
    return null;
  }

  Future<User?> signIn(
      {required String email, required String password}) async {
    try {
      UserCredential user = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      if (user.user != null) {
        CollectionReference userRef = FirebaseFirestore.instance.collection('users');
        userRef.doc(_firebaseAuth.currentUser?.uid).update({"password": password});
      }
      return user.user;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> logOut() async {
    await _firebaseAuth.signOut();
  }
}
