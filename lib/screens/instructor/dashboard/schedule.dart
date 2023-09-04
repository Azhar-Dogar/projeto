import 'package:flutter/material.dart';
import 'package:projeto/extras/app_textstyles.dart';
import 'package:utility_extensions/utility_extensions.dart';
import 'package:projeto/screens/dashboard/classes_screen.dart';
import 'package:projeto/screens/instructor/schedule/availability.dart';

import '../../../extras/colors.dart';

class Schedule extends StatelessWidget {
  const Schedule({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CColors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: CColors.white,
        title: Text(
          "Aulas",
          style: AppTextStyles.subTitleMedium(),
        ),
      ),
      body: Column(
        children: [
          itemWidget(
            Icons.calendar_today_sharp,
            "Minha Agenda",
            () {
              context.push(child: ClassesScreen());
            },
          ),
          itemWidget(
            Icons.access_time,
            "Configurar disponibilidade de aulas",
            () {
              context.push(child: Availability());
            },
          ),
        ],
      ),
    );
  }

  Widget itemWidget(IconData icon, String text, Function() onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Row(
          children: [
            Icon(
              icon,
              color: CColors.black,
              size: 20,
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Text(
                text,
                style: AppTextStyles.captionMedium(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
