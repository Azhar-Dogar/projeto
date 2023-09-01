import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:projeto/extras/app_assets.dart';
import 'package:projeto/extras/app_textstyles.dart';
import 'package:projeto/extras/colors.dart';
import 'package:projeto/extras/extensions.dart';
import 'package:projeto/screens/dashboard/chat/chat_inbox.dart';
import 'package:projeto/widgets/custom_asset_image.dart';
import 'package:projeto/widgets/divider_widget.dart';
import 'package:projeto/widgets/margin_widget.dart';

import '../../widgets/c_profile_app_bar.dart';

class ClassesScreen extends StatefulWidget {
  const ClassesScreen({super.key});

  @override
  State<ClassesScreen> createState() => _ClassesScreenState();
}

class _ClassesScreenState extends State<ClassesScreen> {
  late double width, padding;

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    width = context.width;
    padding = width * 0.04;

    return Scaffold(
      appBar: CustomAppBar("Agenda"),
      body: Column(
        children: [
          // CupertinoSegmentedControl(children: children, onValueChanged: onValueChanged)
          segmentSwitch(),
        ],
      ),
    );
  }

  Widget segmentSwitch() {
    return Container(
      width: double.infinity,
      color: CColors.dashboard,
      alignment: Alignment.center,
      padding: EdgeInsets.only(top: 32, bottom: 32),
      child: Container(
        width: 260,
        decoration: BoxDecoration(
            color: const Color(0xffEEEEEF),
            borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.all(5),
        child: CupertinoSegmentedControl(
          padding: EdgeInsets.zero,
          children: {
            0: segmentChild(0, 'Semana'),
            1: segmentChild(1, 'Mês'),
            2: segmentChild(2, 'Ano'),
          },
          groupValue: _selectedIndex,
          onValueChanged: (value) {
            // This will only change the border radius of the selected child.

            setState(() {
              _selectedIndex = value;
            });
          },
          borderColor: Colors.transparent,
          unselectedColor: Colors.transparent,
          // Background color
          selectedColor: Colors.transparent, // Selected child color
        ),
      ),
    );
  }

  Widget segmentChild(int index, String str) {
    return Container(
      height: 30,
      width: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: _selectedIndex == index ? Colors.white : Colors.transparent,
      ),
      alignment: Alignment.center,
      child: Text(
        str,
        style: AppTextStyles.inter(
            fontWeight: FontWeight.w600,
            fontSize: 12,
            color: _selectedIndex == index
                ? CColors.primary
                : CColors.segmentedGrey),
      ),
    );
  }
}
