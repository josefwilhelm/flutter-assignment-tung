import 'package:flutter/material.dart';
import 'package:flutter_assessment/core/network/network_status.dart';
import 'package:flutter_assessment/models/appointment.dart';

import 'base_service.dart';

abstract class AppointmentService {
  Future<List<Appointment>> fetchAppointments();
}

class AppointmentServiceImpl extends BaseService implements AppointmentService {
  static const APPOINTMENTS_COLLECTION = 'appointments';
  NetworkStatus networkStatus;

  AppointmentServiceImpl({@required this.networkStatus});

  @override
  Future<List<Appointment>> fetchAppointments() async {
    await checkInternetConnection(networkStatus: networkStatus);
    final appointmentCollection =
        fireStoreInstance.collection(APPOINTMENTS_COLLECTION);
    final docs = await appointmentCollection.getDocuments();
    return docs.documents.map((doc) {
      return Appointment.fromJson(doc.data);
    }).toList();
  }
}
