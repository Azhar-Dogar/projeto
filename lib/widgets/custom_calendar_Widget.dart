import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:table_calendar/table_calendar.dart';
import '../extras/app_textstyles.dart';
import '../extras/colors.dart';
import 'package:intl/intl.dart';

class CCalendarWidget extends StatelessWidget {
  const CCalendarWidget(
      {Key? key, required this.startDate, required this.onSelection})
      : super(key: key);

  final DateTime startDate;

  final void Function(DateTime, DateTime) onSelection;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.75),
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 10),
      child: TableCalendar(
        calendarStyle: CalendarStyle(
          selectedDecoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 3),
            color: CColors.primary,
            shape: BoxShape.circle,
          ),
        ),
        focusedDay: startDate,
        firstDay: DateTime(1970),
        lastDay: DateTime(3032),
        onDaySelected: onSelection,
        selectedDayPredicate: (day) => isSameDay(day, startDate),
        headerStyle: HeaderStyle(
          titleTextFormatter: (DateTime focusedDay, value) {
            return DateFormat.MMMM()
                .format(focusedDay)
                .toString()
                .toUpperCase();
          },
          titleTextStyle: AppTextStyles.poppins(
            style: const TextStyle(
              fontWeight: FontWeight.w300,
              fontSize: 18,
            ),
          ),
          formatButtonVisible: false,
          titleCentered: true,
        ),
        daysOfWeekStyle: DaysOfWeekStyle(
            weekdayStyle: AppTextStyles.subTitleMedium(),
            weekendStyle: AppTextStyles.subTitleMedium(),
            dowTextFormatter: (DateTime focusedDay, value) {
              return DateFormat('EEEE')
                  .format(focusedDay)
                  .toString()
                  .toUpperCase()
                  .characters
                  .first;
            }),
      ),
    );
  }
}
