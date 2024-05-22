import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doan_barberapp/shared/models/UserModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class UserRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<UserModel?> fetchUser() async {
    final data = await FirebaseFirestore.instance
        .collection('users')
        .where('uid', isEqualTo: _firebaseAuth.currentUser?.uid)
        .get();
    final doc = data.docs;
    UserModel? user = UserModel.fromMap(doc[0].data());
    return user;
}

  Future<void> saveUserData({UserModel? userModel, File? file}) async{
    try {
      if(file != null) {
        await storeImgToStorage('profilePic/${_firebaseAuth.currentUser?.uid}', file).then((value) {
        if(value != null){
          userModel?.profilePic = value;
        }
      });
      }
      await _firestore.collection('users').doc(userModel?.uid).set(userModel!.toMap());
    } catch (e) {
      rethrow;
    }
  }

  Future<String> storeImgToStorage(String ref, File file) async {
    UploadTask uploadTask = _storage.ref().child(ref).putFile(file);
    TaskSnapshot taskSnapshot = await uploadTask;
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    return downloadUrl;
  }
}
