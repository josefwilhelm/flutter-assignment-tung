import 'package:flutter/material.dart';
import 'package:flutter_assessment/core/network/network_status.dart';
import 'package:flutter_assessment/models/appointment.dart';
import 'package:rxdart/subjects.dart';

import 'base_service.dart';

abstract class AppointmentService {
  Future<List<Appointment>> fetchAppointments();
  Stream<List<Appointment>> get onAppointmentsUpdated;
}

class AppointmentServiceImpl extends BaseService implements AppointmentService {
  static const APPOINTMENTS_COLLECTION = 'appointments';
  NetworkStatus networkStatus;
  PublishSubject<List<Appointment>> _dbNotifier =
      PublishSubject<List<Appointment>>();

  AppointmentServiceImpl({@required this.networkStatus}) {
    fireStoreInstance
        .collection(APPOINTMENTS_COLLECTION)
        .snapshots()
        .listen((data) {
      final res = data.documents.map((doc) {
        return Appointment.fromJson(doc.data);
      }).toList();
      _dbNotifier.add(res);
    });
  }

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

  @override
  Stream<List<Appointment>> get onAppointmentsUpdated => _dbNotifier.stream;
}
