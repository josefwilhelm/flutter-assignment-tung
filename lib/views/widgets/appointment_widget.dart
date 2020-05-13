import 'package:flutter/material.dart';
import 'package:flutter_assessment/models/appointment.dart';
import 'package:flutter_assessment/models/work_order.dart';
import 'package:flutter_assessment/core/utils/date_extension.dart';
import 'package:flutter_assessment/views/widgets/custom_button.dart';

class AppointmentWidget extends StatefulWidget {
  final Appointment appointment;
  final WorkOrder workOrder;

  AppointmentWidget({@required this.appointment, @required this.workOrder});

  @override
  State<StatefulWidget> createState() => AppointmentWidgetState();
}

class AppointmentWidgetState extends State<AppointmentWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          height: 140,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                _buildWorkOrderName(),
                _buildWorkTime(),
                _buildLocation(),
                _buildButtons()
              ]),
        ),
      ),
    );
  }

  _buildButtons() {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          CustomButton(
            text: 'Start travel',
            backGroundColor: Colors.blue[100],
          ),
          CustomButton(
            text: 'Start service',
            backGroundColor: Colors.blue,
          )
        ]);
  }

  _buildLocation() {
    return Row(
      children: <Widget>[
        Icon(
          Icons.local_cafe,
          size: 20,
          color: Colors.blue,
        ),
        Text(
          '${widget.workOrder.city} - ${widget.workOrder.street}',
          style: TextStyle(color: Colors.grey, fontSize: 13),
        )
      ],
    );
  }

  _buildWorkTime() {
    final startTime =
        widget.appointment.startDate.toDate().getHourAndMinuteString();
    final endTime =
        widget.appointment.endDate.toDate().getHourAndMinuteString();
    return Row(
      children: <Widget>[
        Icon(
          Icons.timer,
          size: 20,
          color: Colors.blue,
        ),
        Text(
          '$startTime - $endTime',
          style: TextStyle(color: Colors.grey, fontSize: 14),
        )
      ],
    );
  }

  _buildWorkOrderName() {
    return Text(
      widget.workOrder.name.toUpperCase(),
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: Colors.black,
      ),
    );
  }
}
