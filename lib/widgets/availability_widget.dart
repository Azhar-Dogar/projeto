import 'package:flutter/material.dart';
import 'package:projeto/extras/app_textstyles.dart';
import 'package:projeto/widgets/margin_widget.dart';
import 'package:projeto/widgets/textfield_widget.dart';

import '../extras/colors.dart';

class AvailabilityWidget extends StatefulWidget {
  const AvailabilityWidget({super.key, required this.day});

  final String day;

  @override
  State<AvailabilityWidget> createState() => _AvailabilityWidgetState();
}

class _AvailabilityWidgetState extends State<AvailabilityWidget> {
  bool isShowing = false;

  var startTime = TextEditingController();
  var endTime = TextEditingController();
  var breakStartTime = TextEditingController();
  var breakEndTime = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: CColors.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(
              10,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 18,
                height: 18,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: CColors.white,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text(
                    widget.day,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.titleRegular(),
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    isShowing = !isShowing;
                  });
                },
                icon: Icon(
                  isShowing
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                ),
              ),
            ],
          ),
        ),
        if (isShowing)
          Column(
            children: [
              const MarginWidget(),
              TextFieldWidget(
                controller: startTime,
                label: "Horário de início",
                suffixIcon: Icon(Icons.keyboard_arrow_down, color: CColors.black,),
              ),

              const MarginWidget(),

              TextFieldWidget(
                controller: startTime,
                label: "Horário fim",
                suffixIcon: Icon(Icons.keyboard_arrow_down, color: CColors.black,),
              ),


              const MarginWidget(),

              Row(
                children: [
                  Expanded(
                    child: TextFieldWidget(
                      controller: startTime,
                      label: "Pausa das",
                      suffixIcon: Icon(Icons.keyboard_arrow_down, color: CColors.black,),
                    ),
                  ),


                  const MarginWidget(isHorizontal: true,),


                  Expanded(
                    child: TextFieldWidget(
                      controller: breakEndTime,
                      label: "Pausa ás",
                      suffixIcon: Icon(Icons.keyboard_arrow_down, color: CColors.black,),
                    ),
                  ),
                ],
              ),
              const MarginWidget(),
            ],
          ),
      ],
    );
  }
}
