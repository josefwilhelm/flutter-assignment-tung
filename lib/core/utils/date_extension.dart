import 'package:date_util/date_util.dart';

extension DateTimeExtension on DateTime {
  String description() {
    final currentWeek =
        20; //DateUtil().getWeek(this.month, this.day, this.year);
    final monthName = this.monthName();
    final day = this.day.toString().padLeft(2, '0');
    final year = this.year;
    final description = '$monthName $day, $year - W$currentWeek';
    return description;
  }

  String monthName() {
    const monthNames = [
      "Jan",
      "Feb",
      "Mar",
      "Apr",
      "May",
      "June",
      "July",
      "Aug",
      "Sep",
      "Oct",
      "Nov",
      "Dec"
    ];

    return monthNames[this.month - 1];
  }

  getHourAndMinuteString() {
    return '${this.hour.toString().padLeft(2, '0')} : ${this.minute.toString().padLeft(2, '0')}';
  }

  bool isSameDay(DateTime date) {
    return this.day == date.day &&
        this.month == date.month &&
        this.year == date.year;
  }
}
