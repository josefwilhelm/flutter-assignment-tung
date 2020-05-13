import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_assessment/locator.dart';
import 'package:flutter_assessment/views/view_models/home_view_model.dart';
import 'package:flutter_assessment/views/widgets/appointment_widget.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_assessment/core/utils/date_extension.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final viewModel =
      HomeViewModel(appointmentService: getIt(), workOrderService: getIt());
  CalendarController _calendarController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.onFetchingData().then((_) {
      viewModel.setSelectedDate(DateTime.now());
    });
    _calendarController = CalendarController();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<HomeViewModel>.withConsumer(
        viewModel: viewModel,
        builder: (context, model, child) => Scaffold(
            appBar: _buildAppBar(),
            body: ModalProgressHUD(
              inAsyncCall: viewModel.isLoading,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _buildTableCalendar(),
                  _buildGotoToDayButton(),
                  _buildAppointmentTitle(),
                  _buildListAppointment(),
                ],
              ),
            )));
  }

  _buildAppBar() {
    final dateDescription = DateTime.now().description();
    return AppBar(
      backgroundColor: Colors.blue,
      elevation: 0,
      title: Text(
        dateDescription,
        style: TextStyle(color: Colors.white, fontSize: 20),
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.calendar_today,
            color: Colors.blue,
          ),
          onPressed: viewModel.onLogoutPressed,
        )
      ],
    );
  }

  Widget _buildTableCalendar() {
    return TableCalendar(
      initialCalendarFormat: CalendarFormat.week,
      availableCalendarFormats: {
        CalendarFormat.week: 'Week',
      },
      calendarController: _calendarController,
      // events: _events,
      // holidays: _holidays,
      startingDayOfWeek: StartingDayOfWeek.monday,
      calendarStyle: CalendarStyle(
        selectedColor: Colors.blue[400],
        todayColor: Colors.blue[200],
        markersColor: Colors.blue[700],
        outsideDaysVisible: true,
      ),
      headerStyle: HeaderStyle(
        centerHeaderTitle: true,
        titleTextStyle: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
      ),
      onDaySelected: _onDaySelected,
      onVisibleDaysChanged: _onVisibleDaysChanged,
      onCalendarCreated: _onCalendarCreated,
    );
  }

  void _onDaySelected(DateTime day, List events) {
    viewModel.setSelectedDate(day);
  }

  void _onVisibleDaysChanged(
      DateTime first, DateTime last, CalendarFormat format) {
    print('CALLBACK: _onVisibleDaysChanged');
  }

  void _onCalendarCreated(
      DateTime first, DateTime last, CalendarFormat format) {
    print('CALLBACK: _onCalendarCreated');
  }

  _buildAppointmentTitle() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Text('Appointments'.toUpperCase(),
          style: TextStyle(
            color: Colors.grey,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          )),
    );
  }

  _buildListAppointment() {
    final count = min(viewModel.displayWorkOrders.length,
        viewModel.displayAppointnments.length);
    return count > 0
        ? Expanded(
            child: ListView.separated(
              separatorBuilder: (context, index) {
                return SizedBox(height: 10);
              },
              padding: EdgeInsets.symmetric(horizontal: 10),
              itemBuilder: (context, index) {
                final workOrder = viewModel.displayWorkOrders[index];
                final appointment = viewModel.displayAppointnments[index];
                return AppointmentWidget(
                    appointment: appointment, workOrder: workOrder);
              },
              itemCount: count,
            ),
          )
        : Expanded(
            child: Center(
              child: Text('No appointments',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  )),
            ),
          );
  }

  _buildGotoToDayButton() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          FlatButton(
            onPressed: () {
              final today = DateTime.now();
              setState(() {
                _calendarController.setFocusedDay(today);
                viewModel.setSelectedDate(today);
                _calendarController.setSelectedDay(today);
              });
            },
            child: Text('Go to today',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                )),
          )
        ],
      ),
    );
  }
}
