import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter_assessment/core/network/network_status.dart';
import 'package:flutter_assessment/models/work_order.dart';
import 'package:rxdart/subjects.dart';

import 'base_service.dart';

abstract class WorkOrderService {
  Future<List<WorkOrder>> fetchWorkOrders();
  Stream<List<WorkOrder>> get onWorkOrderUpdated;
}

class WorkOrderServiceImpl extends BaseService implements WorkOrderService {
  static const WORKORDER_COLLECTION = 'workorders';
  NetworkStatus networkStatus;
  PublishSubject<List<WorkOrder>> _dbNotifier =
      PublishSubject<List<WorkOrder>>();

  WorkOrderServiceImpl({@required this.networkStatus}) {
    fireStoreInstance
        .collection(WORKORDER_COLLECTION)
        .snapshots()
        .listen((data) {
      final res = data.documents.map((doc) {
        return WorkOrder.fromJson(doc.data);
      }).toList();
      _dbNotifier.add(res);
    });
  }

  @override
  Future<List<WorkOrder>> fetchWorkOrders() async {
    await checkInternetConnection(networkStatus: networkStatus);
    final appointmentCollection =
        fireStoreInstance.collection(WORKORDER_COLLECTION);
    final docs = await appointmentCollection.getDocuments();
    return docs.documents.map((doc) {
      return WorkOrder.fromJson(doc.data);
    }).toList();
  }

  @override
  Stream<List<WorkOrder>> get onWorkOrderUpdated => _dbNotifier.stream;
}
