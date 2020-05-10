import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter_assessment/core/network/network_status.dart';
import 'package:flutter_assessment/services/appointment_service.dart';
import 'package:flutter_assessment/services/work_oder_service.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_assessment/services/auth_service.dart';
import 'package:flutter_assessment/services/firebase_service.dart';

GetIt getIt = GetIt.instance;

setupLocator() {
  //utils
  getIt.registerLazySingleton<DataConnectionChecker>(
      () => DataConnectionChecker());
  getIt.registerLazySingleton<NetworkStatus>(() => NetworkStatusImpl(getIt()));

  //Services
  getIt.registerSingleton(FirebaseService());
  getIt.registerSingleton(AuthService());

  getIt.registerFactory<AppointmentService>(
      () => AppointmentServiceImpl(networkStatus: getIt()));
  getIt.registerFactory<WorkOrderService>(
      () => WorkOrderServiceImpl(networkStatus: getIt()));
}
