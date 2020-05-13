import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_assessment/core/error/exceptions.dart';
import 'package:flutter_assessment/models/appointment.dart';
import 'package:flutter_assessment/models/work_order.dart';
import 'package:flutter_assessment/services/appointment_service.dart';
import 'package:flutter_assessment/services/work_oder_service.dart';
import 'package:flutter_assessment/locator.dart';
import 'package:flutter_assessment/services/auth_service.dart';
import 'package:flutter_assessment/core/utils/date_extension.dart';

import '../../logger.dart';

class HomeViewModel extends ChangeNotifier {
  WorkOrderService workOrderService;
  AppointmentService appointmentService;
  final log = getLogger("AuthService");

  List<WorkOrder> _workOrders = [];
  List<Appointment> _appointments = [];

  List<WorkOrder> displayWorkOrders = [];
  List<Appointment> displayAppointnments = [];

  bool isLoading = false;

  DateTime selectedDate = DateTime.now();

  HomeViewModel({
    @required this.workOrderService,
    @required this.appointmentService,
  }) {
    workOrderService.onWorkOrderUpdated.listen((newData) {
      print('workOrderService onWorkOrderUpdated');
      _workOrders = newData;
      setSelectedDate(selectedDate);
    });

    appointmentService.onAppointmentsUpdated.listen((newData) {
      print('appointmentService onAppointmentsUpdated');
      _appointments = newData;
      print('${_appointments.last.endDate.toDate()}');
      setSelectedDate(selectedDate);
    });
  }

  _setIsLoading(bool value) {
    if (isLoading == value) return;
    isLoading = value;
    notifyListeners();
  }

  onLogoutPressed() {
    getIt<AuthService>().logout();
  }

  setSelectedDate(DateTime date) {
    _setIsLoading(true);
    selectedDate = date;
    displayAppointnments = this._appointments.where((ap) {
          final start = ap.startDate.toDate();
          return start.isSameDay(selectedDate);
        }).toList() ??
        [];

    _appointments.forEach((appoint) => {print('_appointments ${appoint.id}')});

    final workOrderIds =
        displayAppointnments.map((item) => item.relatedWorkOrder).toList();
    print('workOrderIds $workOrderIds');
    displayWorkOrders = _workOrders.where((od) {
      print('order item id ${od.id}');
      return workOrderIds.contains(od.id);
    }).toList();
    print(
        "displayAppointnments ${displayAppointnments.length}  displayWorkOrders ${displayWorkOrders.length}");
    _setIsLoading(false);
  }

  Future<void> onFetchingData() async {
    _setIsLoading(true);
    try {
      final workOrderFuture = workOrderService.fetchWorkOrders();
      final appointmentFutute = appointmentService.fetchAppointments();
      await Future.wait([workOrderFuture, appointmentFutute]);
      _workOrders = await workOrderFuture;
      _appointments = await appointmentFutute;
      _setIsLoading(false);
      print(
          'did fetch data  workdOders ${_appointments?.length} and appoinments : ${_appointments.length}');
    } on RemoteException catch (ex) {
      print("on fetching data error ${ex.message}");
    } on PlatformException catch (ex) {
      print("on fetching data error ${ex.message}");
    } catch (ex) {
      print("on fetching data error ${ex.toString()}");
    } finally {
      _setIsLoading(false);
    }
  }
}
