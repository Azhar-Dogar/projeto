import 'package:flutter/material.dart';
import 'package:projeto/extras/app_textstyles.dart';
import 'package:projeto/widgets/availability_widget.dart';

import '../../../extras/colors.dart';

class Availability extends StatefulWidget {
  const Availability({Key? key}) : super(key: key);

  @override
  State<Availability> createState() => _AvailabilityState();
}

class _AvailabilityState extends State<Availability> {

  var days = [
    "Segundas-feiras",
    "Terças-feiras",
    "Quartas-feiras",
    "Quintas-feiras",
    "Sextas-feiras",
    "Sábados",
    "Domingos",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CColors.white,
      appBar: AppBar(
        title: const Text("Disponibildiade"),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        margin: const EdgeInsets.only(
          top: 20,
        ),
        child: Column(
          children: [
            Text(
              "Escolha os dias os dias e horários que ficará disponível para aulas:",
              style: AppTextStyles.titleMedium(),
            ),
            Expanded(
              child: ListView.builder(
                itemBuilder: (ctx, i) {
                  return AvailabilityWidget(day: days[i], key: Key(days[i]),);
                },
                itemCount: days.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
