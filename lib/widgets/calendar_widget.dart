import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:projeto/widgets/margin_widget.dart';

import '../extras/app_textstyles.dart';
import '../extras/colors.dart';

typedef Callback = void Function(int);

class CalendarWidget extends StatefulWidget {
  const CalendarWidget({
    super.key,
    this.isAgenda = false,
    this.callback,
  });

  final Callback? callback;
  final bool isAgenda;

  @override
  State<CalendarWidget> createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {

  int selectedIndex = 2;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          for (var i = 0; i < 6; i++) ...[
            dateBox("Sáb", "07", i),
          ]
        ],
      ),
    );
  }

  Widget dateBox(String day, String date, int index) {
    DateTime date = DateTime.now().add(Duration(days: index));
    String dayName = DateFormat('EEE').format(date);
    return InkWell(
      onTap: () {
        selectedIndex = index;
        if (widget.callback != null) {
          widget.callback!(index);
        }
      },
      child: Container(
        width: 53,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
                color: widget.isAgenda && (index == selectedIndex)
                    ? Colors.black
                    : !widget.isAgenda && (index == selectedIndex)
                        ? CColors.primary
                        : Colors.transparent),
            color: CColors.paymentContainer),
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
                date.day.toString(),
                style: AppTextStyles.captionRegular(
                    color: CColors.textFieldBorder),
              ),
              if (widget.isAgenda && (index == 2  || index == 4)) ...[
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
}
