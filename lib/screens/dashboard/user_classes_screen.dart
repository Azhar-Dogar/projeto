import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projeto/extras/app_textstyles.dart';
import 'package:projeto/extras/colors.dart';
import 'package:projeto/extras/constants.dart';
import 'package:projeto/extras/functions.dart';
import 'package:projeto/generated/assets.dart';
import 'package:projeto/model/booking_model.dart';
import 'package:projeto/model/car_model.dart';
import 'package:projeto/model/user_model.dart';
import 'package:projeto/provider/dashboard_provider.dart';
import 'package:projeto/provider/data_provider.dart';
import 'package:projeto/screens/dashboard/home/instructors_screen.dart';
import 'package:projeto/screens/dashboard/reviews/review_instructor.dart';
import 'package:projeto/widgets/custom_asset_image.dart';
import 'package:provider/provider.dart';
import 'package:utility_extensions/utility_extensions.dart';
import 'package:projeto/widgets/button_widget.dart';
import 'package:projeto/widgets/calendar_widget.dart';
import 'package:projeto/widgets/custom_calendar_Widget.dart';
import 'package:projeto/widgets/divider_widget.dart';
import 'package:projeto/widgets/margin_widget.dart';
import '../../model/notification_model.dart';
import '../../widgets/c_profile_app_bar.dart';

class UserClassesScreen extends StatefulWidget {
  const UserClassesScreen({super.key});

  @override
  State<UserClassesScreen> createState() => _UserClassesScreenState();
}

class _UserClassesScreenState extends State<UserClassesScreen> {
  late double width, padding;

  int _selectedIndex = 0;

  DateTime selectedDate = DateTime.now();
  int? yearSelected;
  int? monthSelected;

  late DataProvider dataProvider;

  @override
  Widget build(BuildContext context) {
    width = context.width;
    padding = width * 0.04;

    return Consumer<DataProvider>(builder: (context, value, child) {
      dataProvider = value;

      return Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar("Agenda"),
        body: Column(
          children: [
            segmentSwitch(),
            const MarginWidget(),
            if (_selectedIndex == 0) ...[
              Expanded(child: weekSelection()),
            ] else if (_selectedIndex == 1) ...[
              Expanded(child: monthSelection()),
            ] else ...[
              Expanded(child: yearSelection()),
            ],
          ],
        ),
      );
    });
  }

  Widget yearSelection() {
    return Padding(
      padding: EdgeInsets.only(left: padding, right: padding),
      child: CustomScrollView(
        slivers: [
          const MarginWidget(
            factor: 0.5,
            isSliver: true,
          ),
          SliverGrid.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                childAspectRatio: 1.34,
                mainAxisSpacing: 20,
                crossAxisSpacing: 25),
            itemBuilder: (ctx, index) {
              return yearBox(year: Constants.years()[index]);
            },
            itemCount: Constants.years().length,
          ),
          const MarginWidget(
            isSliver: true,
          ),
          const DividerWidget().toSliver,
          const MarginWidget(
            isSliver: true,
          ),
          if (yearSelected != null) ...[
            SliverGrid.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  childAspectRatio: 1.34,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 25),
              itemBuilder: (ctx, index) {
                return yearBox(month: index);
              },
              itemCount: Constants.months.length,
            ),
            const MarginWidget(
              isSliver: true,
            ),
            const DividerWidget().toSliver,
            const MarginWidget(
              isSliver: true,
            ),
          ],
          if (yearSelected != null && monthSelected != null) ...[
            showBookings(isSliver: true, isYear: true),
            const MarginWidget(
              isSliver: true,
            ),
          ],
        ],
      ),
    );
  }

  Widget yearBox({int? year, int? month}) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (year != null) {
            yearSelected = year;
          } else {
            monthSelected = month!;
            setState(() {
              selectedDate = DateTime(yearSelected!, monthSelected! + 1, 1);
              _selectedIndex = 1;
              yearSelected = null;
              monthSelected = null;
            });

          }
        });
      },
      child: Center(
        child: Container(
          height: 52,
          width: 70,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color:
                  (year != null ? year == yearSelected : month == monthSelected)
                      ? Colors.black
                      : Colors.transparent,
            ),
          ),
          child: Text(
            "${year != null ? year : Constants.months[month!]}",
            style: AppTextStyles.titleRegular(),
          ),
        ),
      ),
    );
  }

  Widget monthSelection() {
    return CustomScrollView(
      slivers: [
        CCalendarWidget(
            bookings: dataProvider.bookings,
            startDate: selectedDate,
            onSelection: (value, date) {
              setState(() {
                selectedDate = value;
              });
            }).toSliver,
        const DividerWidget().toSliver,
        const MarginWidget(
          isSliver: true,
        ),
        showBookings(isSliver: true),
        const MarginWidget(isSliver: true),
      ],
    );
  }

  Widget weekSelection() {
    return Column(
      children: [
        WeekCalendarWidget(
          isAgenda: true,
          selectedDate: selectedDate,
          onTap: (value) {
            setState(() {
              selectedDate = value;
            });
          },
        ),
        const MarginWidget(),
        const DividerWidget(thickness: 2),
        showBookings(),
      ],
    );
  }

  Widget showBookings({bool isSliver = false, bool isYear = false}) {
    List<BookingModel> bookings;
    if (isYear) {
      bookings = dataProvider.bookings
          .where((element) =>
              monthSelected! + 1 == element.date.month &&
              yearSelected == element.date.year)
          .toList();
    } else {
      bookings = dataProvider.bookings
          .where((element) => Functions.isSameDay(element.date, selectedDate))
          .toList();
    }

    if (bookings.isEmpty) {
      return isSliver ? noBooking().toSliver : noBooking();
    }
    return isSliver
        ? SliverList.separated(
            itemBuilder: (ctx, index) {
              return bookingWidget(bookings[index]);
            },
            itemCount: bookings.length,
            separatorBuilder: (BuildContext context, int index) {
              return MarginWidget(factor: 0.5);
            },
          )
        : Expanded(
            child: ListView.separated(
              padding: EdgeInsets.only(top: 15),
              itemBuilder: (ctx, index) {
                return bookingWidget(bookings[index]);
              },
              itemCount: bookings.length,
              separatorBuilder: (BuildContext context, int index) {
                return MarginWidget(factor: 0.5);
              },
            ),
          );
  }

  Widget noBooking() {
    return Column(
      children: [
        const MarginWidget(factor: 0.5),
        Text(
          "Você não tem aula agendada para esse dia",
          style: AppTextStyles.subTitleRegular(),
        ),
        const MarginWidget(),
        Padding(
          padding: EdgeInsets.only(left: padding, right: padding),
          child: ButtonWidget(
            name: "Voltar para home e agendar",
            onPressed: () {
              context.read<DashboardProvider>().selectedIndex = 2;
            },
          ),
        ),
      ],
    );
  }

  Widget bookingWidget(BookingModel bookingModel) {
    UserModel? instructor = dataProvider.getUserById(bookingModel.instructorID);
    CarModel? carModel = dataProvider.getCarById(bookingModel.instructorID);

    print(bookingModel.status);

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
                      subTitle("${instructor!.name}"),
                    ],
                  ),
                ),
                Container(
                  height: 35,
                  width: 35,
                  decoration: BoxDecoration(
                      color: iconColor(bookingModel.status),
                      shape: BoxShape.circle),
                  alignment: Alignment.center,
                  child: getBookingIcon(bookingModel.status),
                )
              ],
            ),
            const MarginWidget(factor: 0.2),
            if (bookingModel.status == "pending") ...[
              Text(
                "O instrutor ainda não confirmou sua aula",
                style:
                    AppTextStyles.captionMedium(color: CColors.textFieldBorder),
              ),
            ] else if (bookingModel.status == "confirmed") ...[
              Text(
                "O instrutor confirmou sua aula!",
                style: AppTextStyles.captionMedium(color: CColors.primary),
              ),
            ] else if (bookingModel.status == "denied" ||
                bookingModel.status == "cancelled" ||
                bookingModel.status == "icancelled") ...[
              Text(
                "O instrutor escolhido não poderá atender sua solicitação, escolha outro instrutor disponível.",
                style: AppTextStyles.captionMedium(color: CColors.primary),
              ),
            ] else ...[
              DividerWidget(),
            ],
            const MarginWidget(factor: 0.2),
            title("Carro"),
            const MarginWidget(factor: 0.2),
            subTitle("${carModel!.vehicle}, ${carModel.year}"),
            const DividerWidget(),
            title("Horário"),
            const MarginWidget(factor: 0.5),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                for (int i = 0; i < bookingModel.totalClasses; i++) ...[
                  timeBox(Functions.formatTime(
                      bookingModel.date.add(Duration(hours: i)))),
                ],
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
                subTitle("R\$ ${bookingModel.amount.toInt()},00"),
              ],
            ),
            const DividerWidget(),
            if (bookingModel.status == "started") ...[
              Text(
                "A aula foi iniciada",
                style: AppTextStyles.captionMedium(color: CColors.primary),
              )
            ] else ...[
              if (bookingModel.status == "pending" ||
                  bookingModel.status == "confirmed" ||
                  bookingModel.status == "denied" ||
                  bookingModel.status == "cancelled" ||
                  bookingModel.status == "icancelled") ...[
                const MarginWidget(factor: 0.2),
                ButtonWidget(
                    name: "Alterar instrutor",
                    onPressed: () {
                      context.push(child: InstructorsScreen(callBack: (value) {
                        try {
                          BookingModel updated =
                              BookingModel.fromMap(bookingModel.toMap());
                          updated.instructorID = value.uid;
                          updated.status = "pending";
                          Constants.bookings
                              .doc(updated.id)
                              .update(updated.toMap());
                        } on FirebaseException catch (e) {
                          print(e);
                        }

                        UserModel user =
                            context.read<DataProvider>().userModel!;

                        print(instructor.uid);
//
                        Functions.sendNotification(
                            NotificationModel(
                                metaData: bookingModel.toMap(),
                                text: "${user.name} solicita aulas",
                                type: "booking",
                                time: DateTime.now().millisecondsSinceEpoch,
                                isRead: false),
                            value.uid);
                      }));
                    }),
                if (bookingModel.status != "denied" &&
                    bookingModel.status != "cancelled" &&
                    bookingModel.status != "icancelled") ...[
                  const MarginWidget(),
                  Align(
                    alignment: Alignment.center,
                    child: InkWell(
                      onTap: () {
                        try {
                          Constants.bookings.doc(bookingModel.id).update({
                            "status": "cancelled",
                          });
                        } on FirebaseException catch (e) {
                          print(e);
                        }
                      },
                      child: Text(
                        "Cancelar aula",
                        style:
                            AppTextStyles.captionMedium(color: CColors.primary),
                      ),
                    ),
                  ),
                ]
              ] else if(bookingModel.status == "completed") ...[
                const MarginWidget(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.star_border,
                        color: CColors.primary,
                      ),
                      const MarginWidget(isHorizontal: true),
                      InkWell(
                        onTap: () {
                          context.push(
                              child: ReviewInstructor(
                            instructor: instructor,
                            bookingModel: bookingModel,
                          ));
                        },
                        child: Text(
                          "Avalie seu instrutor",
                          style: AppTextStyles.captionMedium(
                              color: CColors.primary),
                        ),
                      ),
                    ],
                  ),
              ],
            ],
            const MarginWidget(factor: 0.5),
          ],
        ),
      ),
    );
  }

  Color iconColor(String status) {
    switch (status) {
      case "pending":
        return CColors.blueShade;
      case "denied" || "cancelled" || "icancelled":
        return CColors.pink;
      default:
        return CColors.primary.withOpacity(0.2);
    }
  }

  Widget getBookingIcon(String status) {
    switch (status) {
      case "pending":
        return const CupertinoActivityIndicator();

      case "confirmed":
        return Container(
          child: Icon(
            Icons.calendar_today_sharp,
            size: 18,
          ),
        );
      case "denied" || "cancelled" || "icancelled":
        return CustomAssetImage(
          path: Assets.iconsCancel,
          height: 18,
        );
      case "completed":
        return Icon(
          Icons.done,
          size: 18,
        );
      case "started":
        return Icon(
          Icons.done,
          size: 18,
        );
      default:
        return const CupertinoActivityIndicator();
    }
  }

  Widget timeBox(String time) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: CColors.textFieldBorder)),
      padding: const EdgeInsets.only(top: 4, bottom: 4, left: 8, right: 8),
      child: Text(
        time,
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
