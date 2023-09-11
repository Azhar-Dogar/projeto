import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:projeto/extras/functions.dart';
import 'package:projeto/model/booking.dart';
import 'package:projeto/provider/data_provider.dart';
import 'package:projeto/widgets/margin_widget.dart';
import 'package:provider/provider.dart';

import '../extras/app_textstyles.dart';
import '../extras/colors.dart';

class WeekCalendarWidget extends StatefulWidget {
  const WeekCalendarWidget({
    super.key,
    this.isAgenda = false,
    required this.onTap,
    required this.selectedDate,
  });

  final bool isAgenda;
  final Function(DateTime) onTap;
  final DateTime selectedDate;

  @override
  State<WeekCalendarWidget> createState() => _WeekCalendarWidgetState();
}

class _WeekCalendarWidgetState extends State<WeekCalendarWidget> {
  final ScrollController _controller = ScrollController();

  DateTime dateTime = DateTime.now().subtract(Duration(days: 15));
  List<DateTime> dateList = [];

  late int scrollToIndex;

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < 30; i++) {
      dateList.add(dateTime.add(Duration(days: i)));
    }

    scrollToIndex = dateList.length ~/ 2;

    navigate();
  }

  navigate() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      double itemWidth = 53; // Replace with your item width
      double offset = scrollToIndex * itemWidth;
      _controller.animateTo(
        offset,
        duration: Duration(milliseconds: 500), // Adjust the duration as needed
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Container(
        height: 84,
        child: ListView.separated(
          controller: _controller,
          padding: EdgeInsets.only(left: 10, right: 10),
          scrollDirection: Axis.horizontal,
          itemBuilder: (ctx, index) {
            return dateBox(index);
          },
          itemCount: dateList.length,
          separatorBuilder: (BuildContext context, int index) {
            return const MarginWidget(isHorizontal: true);
          },
        ),
      ),
    );
  }

  Widget dateBox(int index) {
    String dayName = DateFormat('EEE').format(dateList[index]);
    return InkWell(
      onTap: () {
        widget.onTap(dateList[index]);
        setState(() {
          scrollToIndex = index;
        });
      },
      child: Container(
        width: 53,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
                color: widget.isAgenda &&
                        (Functions.isSameDay(
                            widget.selectedDate, dateList[index]))
                    ? Colors.black
                    : !widget.isAgenda &&
                            (Functions.isSameDay(
                                widget.selectedDate, dateList[index]))
                        ? CColors.primary
                        : Colors.transparent,
                width: 2),
            color: Functions.isSameDay(widget.selectedDate, dateList[index])
                ? Colors.white
                : CColors.paymentContainer),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Text(
                dayName,
                style: AppTextStyles.captionRegular(
                    color: CColors.textFieldBorder, size: 10),
              ),
              const MarginWidget(factor: 0.3),
              Text(
                "${DateFormat("dd").format(dateList[index])}",
                style: AppTextStyles.captionRegular(
                    color: CColors.textFieldBorder),
              ),
              if (isBookingDate(index)) ...[
                const MarginWidget(factor: 0.3),
                CircleAvatar(
                  backgroundColor: CColors.primary,
                  radius: 5,
                ),
              ]
            ],
          ),
        ),
      ),
    );
  }

  bool isBookingDate(int index) {
    if (widget.isAgenda) {
      List<BookingModel> bookings = context
          .read<DataProvider>()
          .bookings
          .where((element) =>
              Functions.isSameDay(element.date, dateList[index]))
          .toList();
      return bookings.isNotEmpty;
    } else {
      return false;
    }
  }
}
