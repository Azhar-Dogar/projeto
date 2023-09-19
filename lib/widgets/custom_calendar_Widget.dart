import 'package:flutter/material.dart';
import 'package:projeto/extras/functions.dart';
import 'package:table_calendar/table_calendar.dart';
import '../extras/app_textstyles.dart';
import '../extras/colors.dart';
import 'package:intl/intl.dart';

import '../model/booking_model.dart';

class CCalendarWidget extends StatelessWidget {
  const CCalendarWidget(
      {Key? key,
      required this.startDate,
      required this.onSelection,
      this.bookings})
      : super(key: key);

  final DateTime startDate;
  final List<BookingModel>? bookings;

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
        calendarBuilders: CalendarBuilders(
          todayBuilder: (ctx, dt, dt1) {
            return Center(
              child: Container(
                child: Text("${dt.day}"),
              ),
            );
          },
          defaultBuilder: (ctx, dt, dt1) {
            Color containerColor = Colors.transparent;
            Color textColor = Colors.black;

            if (bookings != null) {
              BookingModel? bookingModel = bookings
                  ?.where((element) => Functions.isSameDay(dt, element.date))
                  .firstOrNull;

              if (bookingModel != null) {
                containerColor = CColors.primary;
                textColor = Colors.white;
              }
            }

            return Center(
              child: Container(
                height: 40,
                width: 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: containerColor,
                ),
                child: Text(
                  "${dt.day}",
                  style: AppTextStyles.subTitleRegular(color: textColor),
                ),
              ),
            );
          },
        ),
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
