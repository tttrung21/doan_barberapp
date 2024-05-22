import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doan_barberapp/common/DropdownItem.dart';
import 'package:doan_barberapp/components/widget/SnackBar.dart';
import 'package:doan_barberapp/shared/models/AppointmentItem.dart';

class DataRepository{
  final _firestore = FirebaseFirestore.instance;


  Future<void> bookAppointment(AppointmentItem appointment) async {
    try {
      DocumentReference appointmentRef = _firestore.collection('appointments').doc();
      String appointmentId = appointmentRef.id;
      await _firestore.collection('appointments').add({
        'userId': appointment.userId,
        'barberId': appointment.barberId,
        'appointmentId': appointmentId,
        'bookedDate': appointment.bookedDate,
        'bookedTime': appointment.bookedTime,
        'services': appointment.services,
        'barberName' : appointment.barberName,
        'estimatedFee' : appointment.estimatedFee
      });
    } catch (e) {
      SnackBarCore.fail(title: e.toString());
      // Handle error
    }
  }
  Future<List<DropdownItem>> getServices() async{
    final data = await FirebaseFirestore.instance.collection('services').get();
    List<DropdownItem> dropdownItems = DropdownItem.fromJsonToList(data.docs.map((doc) => doc.data()).toList());
    return dropdownItems;
  }
}