import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_assessment/core/error/exceptions.dart';
import 'package:flutter_assessment/services/appointment_service.dart';
import 'package:flutter_assessment/services/work_oder_service.dart';
import 'package:flutter_assessment/locator.dart';
import 'package:flutter_assessment/services/auth_service.dart';

import '../../logger.dart';

class HomeViewModel extends ChangeNotifier {
  WorkOrderService workOrderService;
  AppointmentService appointmentService;
  final log = getLogger("AuthService");

  HomeViewModel({
    @required this.workOrderService,
    @required this.appointmentService,
  });

  Stream<List<Route>> list;
  onLogoutPressed() {
    getIt<AuthService>().logout();
  }

  onFetchingData() async {
    print("onFetchingData");
    try {
      final workOrderFuture = workOrderService.fetchWorkOrders();
      final appointmentFutute = appointmentService.fetchAppointments();
      await Future.wait([workOrderFuture, appointmentFutute]);
      final workdOders = await workOrderFuture;
      final appoinments = await appointmentFutute;

      print(
          'did fetch data  workdOders ${workdOders?.length} and appoinments : ${appoinments.length}');
    } on RemoteException catch (ex) {
      print("on fetching data error ${ex.message}");
    } on PlatformException catch (ex) {
      print("on fetching data error ${ex.message}");
    } catch (ex) {
      print("on fetching data error ${ex.toString()}");
    }
  }
}
