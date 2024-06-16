import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doan_barberapp/common/DropdownItem.dart';
import 'package:doan_barberapp/components/widget/SnackBar.dart';
import 'package:doan_barberapp/shared/models/AppointmentItem.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class DataRepository {
  final _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<void> bookAppointment(AppointmentItem appointment) async {
    try {
      await _firestore.collection('appointments').add({
        'userId': appointment.userId,
        'barberId': appointment.barberId,
        'appointmentId': '',
        'bookedDate': appointment.bookedDate,
        'bookedTime': appointment.bookedTime,
        'services': appointment.services,
        'servicesId': appointment.servicesId,
        'servicesPrice': appointment.servicesPrice,
        'servicesCode': appointment.servicesCode,
        'barberName': appointment.barberName,
        'estimatedFee': appointment.estimatedFee,
        'alarmId': appointment.alarmId,
        'isCancelled': appointment.isCancelled,
      }).then((value) => value.update({'appointmentId': value.id}));
    } catch (e) {
      SnackBarCore.fail(title: e.toString());
      // Handle error
    }
  }

  Future<void> updateAppointment(AppointmentItem appointment) async {
    try {
      await _firestore.collection('appointments').doc(appointment.appointmentId).update({
        // 'userId': appointment.userId,
        'barberId': appointment.barberId,
        // 'appointmentId': appointment.appointmentId,
        'bookedDate': appointment.bookedDate,
        'bookedTime': appointment.bookedTime,
        'services': appointment.services,
        'servicesId': appointment.servicesId,
        'servicesPrice': appointment.servicesPrice,
        'servicesCode': appointment.servicesCode,
        'barberName': appointment.barberName,
        'estimatedFee': appointment.estimatedFee,
        'alarmId': appointment.alarmId,
        // 'isCancelled': appointment.isCancelled,
      });
    } catch (e) {
      SnackBarCore.fail(title: e.toString());
      // Handle error
    }
    // final data = await _firestore.collection('appointments').doc(appointment.appointmentId).get();
  }

  Future<List<DropdownItem>> getServices() async {
    final data = await FirebaseFirestore.instance.collection('services').get();
    List<DropdownItem> dropdownItems = DropdownItem.fromJsonToList(
        data.docs.map((doc) => doc.data()).toList());
    return dropdownItems;
  }

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> getBarbers() async {
    final barberDocs = await FirebaseFirestore.instance
        .collection('users')
        .where('role', isEqualTo: 'barber')
        .get();
    return barberDocs.docs;
  }

  Future<void> saveImage({File? file}) async {
    try {
      String? img;
      if (file != null) {
        await storeImgToGalleryStorage(
                'imageGallery/${_firebaseAuth.currentUser?.uid}', file)
            .then((value) {
          if (value != null) {
            img = value;
          }
        });
      }
      await _firestore.collection('gallery').add({'image': img});
    } catch (e) {
      rethrow;
    }
  }

  Future<String> storeImgToGalleryStorage(String ref, File file) async {
    UploadTask uploadTask = _storage.ref().child(ref).putFile(file);
    TaskSnapshot taskSnapshot = await uploadTask;
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    return downloadUrl;
  }
}
