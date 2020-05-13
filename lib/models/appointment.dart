import 'package:cloud_firestore/cloud_firestore.dart';

class Appointment {
  Timestamp startDate;
  Timestamp endDate;
  String id;
  String relatedWorkOrder;

  Appointment({
    this.id,
    this.startDate,
    this.endDate,
    this.relatedWorkOrder,
  });

  factory Appointment.fromJson(Map<String, dynamic> json) {
    try {
      var entity = Appointment();
      entity.id = json['id'];
      entity.relatedWorkOrder = json['relatedWorkorder'];
      entity.startDate = json['startDate'];
      entity.endDate = json['endDate'];
      return entity;
    } catch (ex) {
      print("Appointment parse error ${ex.toString()}");
    }
  }
}
