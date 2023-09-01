import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:projeto/extras/app_assets.dart';
import 'package:projeto/extras/app_textstyles.dart';
import 'package:projeto/extras/colors.dart';
import 'package:projeto/extras/constants.dart';
import 'package:projeto/extras/extensions.dart';
import 'package:projeto/screens/dashboard/chat/chat_inbox.dart';
import 'package:projeto/widgets/button_widget.dart';
import 'package:projeto/widgets/calendar_widget.dart';
import 'package:projeto/widgets/custom_asset_image.dart';
import 'package:projeto/widgets/custom_calendar_Widget.dart';
import 'package:projeto/widgets/divider_widget.dart';
import 'package:projeto/widgets/margin_widget.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../widgets/c_profile_app_bar.dart';

class ClassesScreen extends StatefulWidget {
  const ClassesScreen({super.key});

  @override
  State<ClassesScreen> createState() => _ClassesScreenState();
}

class _ClassesScreenState extends State<ClassesScreen> {
  late double width, padding;

  int _selectedIndex = 0;

  int selectedDate = 3;
  int yearNow = 2016;
  int year1 = 2020;

  // late CalendarController _calendarController;

  late DateTime _selectedDate;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectedDate = DateTime.now();
    // _calendarController = CalendarController();
  }

  @override
  Widget build(BuildContext context) {
    width = context.width;
    padding = width * 0.04;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar("Agenda"),
      body: SingleChildScrollView(
        child: Column(
          children: [
            segmentSwitch(),
            const MarginWidget(),
            if (_selectedIndex == 0) ...[
              weekSelection(),
            ] else if (_selectedIndex == 1) ...[
              monthSelection(),
            ] else ...[
              Padding(
                padding: EdgeInsets.only(left: padding, right: padding),
                child: Column(
                  children: [
                    const MarginWidget(factor: 0.5),
                    yearRow(yearNow),
                    const MarginWidget(factor: 1.5),
                    yearRow(year1),
                    const MarginWidget(),
                    const DividerWidget(),
                    const MarginWidget(),
                    Wrap(
                      children: [
                        for (int i = 0; i < 10; i++) yearBox("Jan"),
                      ],
                    )
                  ],
                ),
              )
            ],
          ],
        ),
      ),
    );
  }

  Widget yearRow(int year) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          for (int i = 0; i < 4; i++) ...[
            yearBox("${year + i}"),
          ]
        ],
      ),
    );
  }

  Widget yearBox(String str) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
              color: str == "2023" ? Colors.black : Colors.transparent)),
      child: Text(
        str,
        style: AppTextStyles.titleRegular(),
      ),
    );
  }

  Widget monthSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CCalendarWidget(
            startDate: _selectedDate,
            onSelection: (value, date) {
              setState(() {
                _selectedDate = value;
              });
            }),
        const DividerWidget(),
        const MarginWidget(),
        if (_selectedDate.day == 17) ...[
          instructorWidget(),
        ] else ...[
          Text(
            "Você não tem aula agendada para esse dia",
            style: AppTextStyles.subTitleRegular(),
          ),
        ],
        const MarginWidget(),
      ],
    );
  }

  Widget weekSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CalendarWidget(
          isAgenda: true,
          callback: (value) {
            setState(() {
              selectedDate = value;
            });
          },
        ),
        const MarginWidget(),
        const DividerWidget(thickness: 2),
        const MarginWidget(),
        if (selectedDate == 2 || selectedDate == 4) ...[
          instructorWidget(),
        ] else ...[
          Text(
            "Você não tem aula agendada para esse dia",
            style: AppTextStyles.subTitleRegular(),
          ),
          const MarginWidget(),
          Padding(
            padding: EdgeInsets.only(left: padding, right: padding),
            child: ButtonWidget(
              name: "Voltar para home e agendar",
              onPressed: () {},
            ),
          ),
        ],
      ],
    );
  }

  Widget instructorWidget() {
    selectedDate = 2;
    return Padding(
      padding: EdgeInsets.only(left: padding, right: padding),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
          boxShadow: Constants.shadow(),
        ),
        padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      title("Instrutor"),
                      const MarginWidget(factor: 0.2),
                      subTitle("Annette Johnson"),
                    ],
                  ),
                ),
                Container(
                  height: 35,
                  width: 35,
                  decoration: BoxDecoration(
                      color: CColors.primary.withOpacity(0.2),
                      shape: BoxShape.circle),
                  alignment: Alignment.center,
                  child: selectedDate == 2
                      ? const Icon(
                          Icons.done,
                          size: 20,
                        )
                      : const CupertinoActivityIndicator(),
                )
              ],
            ),
            if (selectedDate == 4) ...[
              const MarginWidget(factor: 0.2),
              Text(
                "O instrutor ainda não confirmou sua aula",
                style:
                    AppTextStyles.captionMedium(color: CColors.textFieldBorder),
              ),
              const MarginWidget(factor: 0.2),
            ] else ...[
              const DividerWidget(),
            ],
            title("Carro"),
            const MarginWidget(factor: 0.2),
            subTitle("Celta, 2018"),
            const DividerWidget(),
            title("Horário"),
            const MarginWidget(factor: 0.5),
            Row(
              children: [
                timeBox(),
                const MarginWidget(isHorizontal: true, factor: 0.8),
                timeBox(),
              ],
            ),
            const DividerWidget(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                title("Hora / Aula"),
                title("Total"),
              ],
            ),
            const MarginWidget(factor: 0.5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                subTitle("R\$ 80,00"),
                subTitle("R\$ 160,00"),
              ],
            ),
            const DividerWidget(),
            if (selectedDate == 4) ...[
              const MarginWidget(factor: 0.2),
              ButtonWidget(name: "Alterar instrutor", onPressed: () {}),
              const MarginWidget(),
              Align(
                alignment: Alignment.center,
                child: Text(
                  "Cancelar aula",
                  style: AppTextStyles.captionMedium(color: CColors.primary),
                ),
              ),
            ] else ...[
              const MarginWidget(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.star_border,
                    color: CColors.primary,
                  ),
                  const MarginWidget(isHorizontal: true),
                  Text(
                    "Avalie seu instrutor",
                    style: AppTextStyles.captionMedium(color: CColors.primary),
                  ),
                ],
              ),
            ],
            const MarginWidget(factor: 0.5),
          ],
        ),
      ),
    );
  }

  Widget timeBox() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: CColors.textFieldBorder)),
      padding: const EdgeInsets.only(top: 4, bottom: 4, left: 8, right: 8),
      child: Text(
        "10h00",
        style: AppTextStyles.subTitleRegular(),
      ),
    );
  }

  Text subTitle(String str) {
    return Text(
      str,
      style: AppTextStyles.subTitleRegular(),
    );
  }

  Text title(String str) {
    return Text(
      str,
      style: AppTextStyles.subTitleRegular(color: CColors.textFieldBorder),
    );
  }

  Widget segmentSwitch() {
    return Container(
      width: double.infinity,
      color: CColors.dashboard,
      alignment: Alignment.center,
      padding: const EdgeInsets.only(top: 32, bottom: 32),
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
