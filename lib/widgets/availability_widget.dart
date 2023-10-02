import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projeto/extras/app_textstyles.dart';
import 'package:projeto/extras/functions.dart';
import 'package:projeto/model/availability_model.dart';
import 'package:projeto/widgets/ctimerpicker.dart';
import 'package:projeto/widgets/margin_widget.dart';
import 'package:projeto/widgets/textfield_widget.dart';
import 'package:utility_extensions/extensions/font_utilities.dart';
import 'package:utility_extensions/extensions/functions.dart';

import '../extras/colors.dart';
import '../extras/constants.dart';

class AvailabilityWidget extends StatefulWidget {
  const AvailabilityWidget({super.key, required this.availability});

  final AvailabilityModel availability;

  @override
  State<AvailabilityWidget> createState() => _AvailabilityWidgetState();
}

class _AvailabilityWidgetState extends State<AvailabilityWidget> {
  bool isShowing = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
            color: CColors.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(
              10,
            ),
          ),
          child: InkWell(
            onTap: () {
              setState(() {
                isShowing = !isShowing;
              });
            },
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      widget.availability.isAvailable =
                          !widget.availability.isAvailable;
                    });
                  },
                  child: Container(
                    width: 18,
                    height: 18,
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: CColors.white,
                    ),
                    child: !widget.availability.isAvailable
                        ? null
                        : Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: CColors.primary,
                            ),
                          ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text(
                      widget.availability.day,
                      textAlign: TextAlign.center,
                      style: AppTextStyles.titleRegular(),
                    ),
                  ),
                ),
                Icon(
                  isShowing
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                )
              ],
            ),
          ),
        ),
        if (isShowing)
          Column(
            children: [
              const MarginWidget(),
              InkWell(
                onTap: () {
                  pickTime(widget.availability.startTime);
                },
                child: TextFieldWidget(
                  controller: widget.availability.startTime,
                  label: "Horário de início",
                  textColor: CColors.black,
                  suffixIcon: Icon(
                    Icons.keyboard_arrow_down,
                    color: CColors.black,
                  ),
                  enabled: false,
                ),
              ),
              const MarginWidget(),
              InkWell(
                onTap: () {
                  pickTime(widget.availability.endTime);
                },
                child: TextFieldWidget(
                  controller: widget.availability.endTime,
                  label: "Horário fim",
                  textColor: CColors.black,
                  suffixIcon: Icon(
                    Icons.keyboard_arrow_down,
                    color: CColors.black,
                  ),
                  enabled: false,
                ),
              ),
              const MarginWidget(),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        pickTime(widget.availability.breakStart);
                      },
                      child: TextFieldWidget(
                        controller: widget.availability.breakStart,
                        label: "Pausa das",
                        textColor: CColors.black,
                        suffixIcon: Icon(
                          Icons.keyboard_arrow_down,
                          color: CColors.black,
                        ),
                        enabled: false,
                      ),
                    ),
                  ),
                  const MarginWidget(
                    isHorizontal: true,
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () async {
                        await pickTime(widget.availability.breakEnd);
                        if (validateFields([
                          widget.availability.startTime,
                          widget.availability.endTime,
                          widget.availability.breakStart,
                          widget.availability.breakEnd,
                        ])) {
                          await Constants.users
                              .doc(Constants.uid())
                              .collection("availability")
                              .doc((days.indexOf(widget.availability.day) + 1)
                                  .toString())
                              .update(widget.availability.toMap());
                        }
                      },
                      child: TextFieldWidget(
                        controller: widget.availability.breakEnd,
                        label: "Pausa ás",
                        textColor: CColors.black,
                        suffixIcon: Icon(
                          Icons.keyboard_arrow_down,
                          color: CColors.black,
                        ),
                        enabled: false,
                      ),
                    ),
                  ),
                ],
              ),
              const MarginWidget(factor: 0.7),
            ],
          ),
      ],
    );
  }

  pickTime(TextEditingController controller) async {
    var duration = controller.text.trim().isEmpty
        ? Duration()
        : Duration(
            hours: int.tryParse(controller.text.split(":").first) ?? 0,
            minutes: int.tryParse(controller.text.split(":").last) ?? 0);
    await showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) {
        return _buildContainer(CTimerPicker(
            duration: duration,
            onTimerDurationChanged: (Duration changeTimer) {
              var hours = changeTimer.inHours;
              var mins = changeTimer.inMinutes % 60;
              controller.text =
                  '${hours < 10 ? "0$hours" : hours}:${mins < 10 ? "0$mins" : mins}';
            }));
      },
    );
  }

  Duration initialTimer = const Duration();
  var time;

  // Widget timerPicker(TextEditingController controller, Duration duration) {
  //   return CupertinoTimerPicker(
  //     mode: CupertinoTimerPickerMode.hm,
  //     initialTimerDuration: duration,
  //     onTimerDurationChanged: (Duration changeTimer) {
  //       var hours = changeTimer.inHours;
  //       var mins = changeTimer.inMinutes % 60;
  //       controller.text =
  //           '${hours < 10 ? "0$hours" : hours}:${mins < 10 ? "0$mins" : mins}';
  //     },
  //   );
  // }

  Widget _buildContainer(Widget picker) {
    return Container(
      height: 350,
      padding: const EdgeInsets.only(top: 6.0),
      color: CupertinoColors.white,
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            MarginWidget(),
            Text(
              "Selecione a hora",
              style: AppTextStyles.poppins(
                  style: TextStyle(
                color: CColors.black,
                fontSize: 18,
                fontWeight: FontWeights.bold,
                decoration: TextDecoration.none,
              )),
            ),
            MarginWidget(),
            Container(
              child: DefaultTextStyle(
                style: const TextStyle(
                  color: CupertinoColors.black,
                  fontSize: 22.0,
                ),
                child: picker,
              ),
            ),
          ],
        ),
      ),
    );
  }

  var days = [
    "Segundas-feiras",
    "Terças-feiras",
    "Quartas-feiras",
    "Quintas-feiras",
    "Sextas-feiras",
    "Sábados",
    "Domingos",
  ];
}
