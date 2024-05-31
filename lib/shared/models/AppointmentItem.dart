import 'package:cloud_firestore/cloud_firestore.dart';

class AppointmentItem{
  String? appointmentId;
  String? barberId;
  String? userId;
  String? bookedDate;
  String? bookedTime;
  String? services;
  String? barberName;
  int? estimatedFee;
  int? isCancelled;
  /// 0 la default, 1 la pending, 2 la huy, 3 la hoan thanh
  AppointmentItem({
    this.appointmentId,this.barberId,this.userId,this.bookedDate,this.bookedTime,this.services,this.barberName,this.estimatedFee,this.isCancelled
});
  factory AppointmentItem.fromDocument(DocumentSnapshot document) {
    Map<String, dynamic>? data = document.data() as Map<String, dynamic>?;
    return AppointmentItem(
      appointmentId: data?['appointmentId'],
      barberId: data?['barberId'],
      userId: data?['userId'],
      bookedTime: data?['bookedTime'],
      bookedDate: data?['bookedDate'],
      services: data?['services'],
      barberName: data?['barberName'],
      estimatedFee: data?['estimatedFee'],
      isCancelled: data?['isCancelled']
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'appointmentId': appointmentId,
      'barberId': barberId,
      'userId' : userId,
      'bookedTime' : bookedTime,
      'bookedDate' : bookedDate,
      'services': services,
      'barberName' : barberName,
      'estimatedFee' : estimatedFee,
      'isCancelled' : isCancelled
    };
  }
}