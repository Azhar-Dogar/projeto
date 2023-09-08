import 'package:flutter/material.dart';
import 'package:projeto/extras/app_textstyles.dart';
import '../../../widgets/custom_calendar_Widget.dart';

typedef DateValue = void Function(DateTime);

class CalendarScreen extends StatefulWidget {
  const CalendarScreen(
      {Key? key, required this.selectedDate, required this.callBack})
      : super(key: key);

  final DateTime selectedDate;
  final DateValue callBack;

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  late DateTime selected;

  @override
  void initState() {
    super.initState();

    selected = widget.selectedDate;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Selecione a data da aula",
          style: AppTextStyles.captionMedium(),
        ),
      ),
      body: Center(
        child: CCalendarWidget(
            startDate: selected,
            onSelection: (value, date) {
              setState(() {
                selected = date;
              });
              widget.callBack(date);

            }),
      ),
    );
  }
}
