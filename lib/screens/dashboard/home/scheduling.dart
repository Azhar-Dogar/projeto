import 'package:flutter/material.dart';
import 'package:projeto/extras/app_assets.dart';
import 'package:projeto/extras/app_textstyles.dart';
import 'package:projeto/widgets/button_widget.dart';
import 'package:projeto/widgets/instructor_widget.dart';
import 'package:projeto/widgets/margin_widget.dart';
import 'package:projeto/widgets/textfield_widget.dart';

import '../../../extras/colors.dart';

class SchedulingScreen extends StatefulWidget {
  const SchedulingScreen({super.key});

  @override
  State<SchedulingScreen> createState() => _SchedulingScreenState();
}

class _SchedulingScreenState extends State<SchedulingScreen> {
  bool sentMessage = false;
  TextEditingController time = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CColors.dashboard,
      appBar: AppBar(
        centerTitle: true,
        // leading: const Icon(Icons.arrow_back),
        title: Text(
          "Scheduling",
          style: AppTextStyles.captionMedium(size: 14),
        ),
        actions: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Credit",
                style: AppTextStyles.captionMedium(),
              ),
              Text(
                "R\$ 800,00",
                style: AppTextStyles.captionMedium(color: CColors.primary),
              )
            ],
          )
        ],
      ),
      body: SingleChildScrollView(
        child: (!sentMessage)
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InstructorWidget(
                    name: "Annette Johnson",
                    imagePath: AppImages.instructor,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Change Instructor",
                        style:
                            AppTextStyles.captionMedium(color: CColors.primary),
                      ),
                    ],
                  ),
                  const MarginWidget(),
                  informationWidget()
                ],
              )
            : confirmMessage(),
      ),
    );
  }

  Widget informationWidget() {
    return Card(
      color: CColors.white,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Class Information",
              style: AppTextStyles.subTitleMedium(),
            ),
            const MarginWidget(),
            TextFieldWidget(
              controller: time,
              borderColor: CColors.textFieldBorder,
              label: "Time",
              suffixIcon: const Icon(Icons.keyboard_arrow_down),
            ),
            const MarginWidget(),
            TextFieldWidget(
                controller: time,
                borderColor: CColors.textFieldBorder,
                label: "Number of classes",
                suffixIcon: const Icon(Icons.keyboard_arrow_down)),
            const MarginWidget(),
            TextFieldWidget(
              controller: time,
              borderColor: CColors.textFieldBorder,
              label: "Amount",
            ),
            const MarginWidget(),
            ButtonWidget(
                name: "Confirm",
                onPressed: () {
                  setState(() {
                    sentMessage = true;
                  });
                })
          ],
        ),
      ),
    );
  }

  Widget confirmMessage() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: CColors.checkBackground,
            ),
            child: const Padding(
              padding: EdgeInsets.all(4.0),
              child: Icon(
                Icons.check,
              ),
            ),
          ),
          Text(
            "Sua solicitação de aula foi enviada",
            style: AppTextStyles.subTitleMedium(size: 16),
          ),
          const MarginWidget(),
          Text(
            textAlign:TextAlign.center,
            "Quando o instrutor confirmar sua aula, você receberá uma notificaçã",
            style: AppTextStyles.captionMedium(size: 14),
          )
        ],
      ),
    );
  }
}
