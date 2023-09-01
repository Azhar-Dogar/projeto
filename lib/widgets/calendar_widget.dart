import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

import '../extras/app_textstyles.dart';
import '../extras/colors.dart';

class CalendarWidget extends StatelessWidget {
  const CalendarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for(var i=0; i<7;i++)
          dateBox("Sáb", "07",i)
      ],
    );
  }
  Widget dateBox(String day,String date,int index){
    DateTime date = DateTime.now().add(Duration(days: index));
    String dayName = DateFormat('EEE').format(date);
    return Container(
      width: 40,
      margin: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),color: CColors.paymentContainer),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          Text(dayName,style: AppTextStyles.captionRegular(color: CColors.textFieldBorder,size: 10),),
          Text(date.day.toString(),style: AppTextStyles.captionRegular(color: CColors.textFieldBorder),),
        ],),
      ),
    );
  }
}
