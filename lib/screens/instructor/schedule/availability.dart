import 'package:flutter/material.dart';
import 'package:projeto/extras/app_textstyles.dart';
import 'package:projeto/provider/data_provider.dart';
import 'package:projeto/widgets/availability_widget.dart';
import 'package:provider/provider.dart';
import 'package:utility_extensions/utility_extensions.dart';

import '../../../extras/colors.dart';

class Availability extends StatefulWidget {
  const Availability({Key? key}) : super(key: key);

  @override
  State<Availability> createState() => _AvailabilityState();
}

class _AvailabilityState extends State<Availability> {


  late DataProvider provider;
  @override
  Widget build(BuildContext context) {

    return Consumer<DataProvider>(
      builder: (context, value, child) {
        provider = value;
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
                      var availability = provider.availability;
                      return AvailabilityWidget(key: Key(availability[i].day), availability: availability[i],);
                    },
                    itemCount: provider.availability.length,
                  ),
                ),
              ],
            ),
          ),
        );
      }
    );
  }
}
