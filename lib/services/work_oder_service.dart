import 'package:flutter/foundation.dart';
import 'package:flutter_assessment/core/network/network_status.dart';
import 'package:flutter_assessment/models/work_order.dart';

import 'base_service.dart';

abstract class WorkOrderService {
  Future<List<WorkOrder>> fetchWorkOrders();
}

class WorkOrderServiceImpl extends BaseService implements WorkOrderService {
  static const WORKORDER_COLLECTION = 'workorders';
  NetworkStatus networkStatus;

  WorkOrderServiceImpl({@required this.networkStatus});

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
}
