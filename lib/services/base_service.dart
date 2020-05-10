import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_assessment/core/error/exceptions.dart';
import 'package:flutter_assessment/core/network/network_status.dart';

import '../logger.dart';

abstract class BaseService {
  var fireStoreInstance = Firestore.instance;
  final logger = getLogger("FirebaseService");

  Future<void> checkInternetConnection({NetworkStatus networkStatus}) async {
    final isConnected = await networkStatus?.isConnected ?? true;
    if (!isConnected) {
      throw RemoteException(code: 0, message: NETWORK_ERROR_MESSAGE);
    }
  }
}
