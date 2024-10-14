import 'package:cnattendance/provider/leavecalendarprovider.dart';
import 'package:cnattendance/widget/holiday/holidaycard.dart';
import 'package:cnattendance/widget/holiday/holidaycardview.dart';
import 'package:cnattendance/widget/leavecalendar/leavelistcardview.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HolidayListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final holiday = Provider.of<LeaveCalendarProvider>(context).employeeHoliday;
    return holiday != null
        ? Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Holidaycard(
              id: holiday.id,
              name: holiday.title,
              month: DateFormat("MMM").format(holiday.dateTime),
              day: DateFormat("dd").format(holiday.dateTime),
              desc: holiday.description,
              isPublicHoliday: holiday.isPublicHoliday),
        )
        : SizedBox.shrink();
  }
}
