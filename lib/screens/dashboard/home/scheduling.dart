import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:projeto/extras/app_textstyles.dart';
import 'package:projeto/extras/constants.dart';
import 'package:projeto/extras/functions.dart';
import 'package:projeto/model/user_model.dart';
import 'package:projeto/provider/data_provider.dart';
import 'package:projeto/screens/dashboard/home/calendar_screen.dart';
import 'package:projeto/widgets/ctimerpicker.dart';
import 'package:projeto/widgets/drop_down_widget.dart';
import 'package:provider/provider.dart';
import 'package:utility_extensions/utility_extensions.dart';
import 'package:projeto/widgets/button_widget.dart';
import 'package:projeto/widgets/calendar_widget.dart';
import 'package:projeto/widgets/instructor_widget.dart';
import 'package:projeto/widgets/margin_widget.dart';
import 'package:projeto/widgets/textfield_widget.dart';
import '../../../extras/colors.dart';
import '../../../model/availability_model.dart';
import '../../../model/booking_model.dart';
import '../../../model/notification_model.dart';
import 'instructors_screen.dart';

class SchedulingScreen extends StatefulWidget {
  const SchedulingScreen({super.key, required this.instructor});

  final UserModel instructor;

  @override
  State<SchedulingScreen> createState() => _SchedulingScreenState();
}

class _SchedulingScreenState extends State<SchedulingScreen> {
  bool sentMessage = false;
  TextEditingController time = TextEditingController();
  TextEditingController amount = TextEditingController();

  DateTime selectedDate = DateTime.now();

  String? selectedClasses;

  late UserModel instructor;
  late DataProvider dataProvider;

  List<AvailabilityModel> availability = [];

  bool rebuild = false;

  @override
  void initState() {
    super.initState();
    instructor = widget.instructor;
    dataProvider = context.read<DataProvider>();
    getInstructorAvailability();
  }

  getInstructorAvailability() async {
    var data = await Constants.users
        .doc(widget.instructor.uid)
        .collection("availability")
        .get();

    var docs = data.docs;

    availability = List.generate(
        docs.length, (index) => AvailabilityModel.fromMap(docs[index].data()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CColors.dashboard,
      appBar: buildAppBar(context),
      body: (!sentMessage)
          ? SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      color: CColors.white,
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                Constants.monthMap[DateFormat("MMMM")
                                        .format(selectedDate)] ??
                                    "",
                                style: AppTextStyles.titleMedium(),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5.0),
                            child: WeekCalendarWidget(
                              rebuild: rebuild,
                              onTap: (value) {
                                setState(() {
                                  selectedDate = value;
                                  rebuild = false;
                                });
                              },
                              selectedDate: selectedDate,
                            ),
                          ),
                          const MarginWidget(factor: 0.5),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12.0),
                            child: InkWell(
                              onTap: () {
                                context.push(
                                  child: CalendarScreen(
                                      key: Key("${Random().nextInt(1000)}"),
                                      selectedDate: selectedDate,
                                      callBack: (date) {
                                        setState(() {
                                          selectedDate = date;
                                          rebuild = true;
                                        });
                                      }),
                                );
                              },
                              child: Text(
                                "Abrir Calendário",
                                style: AppTextStyles.captionMedium(
                                    color: CColors.primary),
                              ),
                            ),
                          ),
                          const MarginWidget(factor: 0.5),
                        ],
                      )),
                  InstructorWidget(
                    user: instructor,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          Functions.push(context, InstructorsScreen(
                            callBack: (instructor) {
                              setState(() {
                                this.instructor = instructor;
                              });
                            },
                          ));
                        },
                        child: Text(
                          "Trocar Instrutor",
                          style: AppTextStyles.captionMedium(
                              color: CColors.primary),
                        ),
                      ),
                    ],
                  ),
                  const MarginWidget(),
                  informationWidget()
                ],
              ),
            )
          : confirmMessage(),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: CColors.white,
      centerTitle: true,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: CColors.black,
        ),
        onPressed: () {
          context.pop();
        },
      ),
      title: Text(
        "Agendamento",
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
              "R\$ ${dataProvider.userModel?.credits!.toInt() ?? 0},00",
              style: AppTextStyles.captionMedium(color: CColors.primary),
            )
          ],
        )
      ],
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
              "Informações da Aula",
              style: AppTextStyles.subTitleMedium(),
            ),
            const MarginWidget(),
            timeField(),
            const MarginWidget(),
            DropDownWidget(
                selectedValue: selectedClasses,
                dropdownItems: ["1", "2"],
                onSelect: (value) {
                  setState(() {
                    selectedClasses = value;
                    amount.text = "${int.parse(value) * 80}";
                  });
                },
                label: "Quantidade de Aulas"),
            const MarginWidget(),
            TextFieldWidget(
              enabled: false,
              controller: amount,
              borderColor: CColors.textFieldBorder,
              label: "Valor Total",
            ),
            const MarginWidget(),
            ButtonWidget(
                name: "Confirmar",
                onPressed: () async {
                  if (time.text.isEmpty) {
                    Functions.showSnackBar(
                        context, "Selecione a hora primeiro");
                    return;
                  }
                  if (selectedClasses == null) {
                    Functions.showSnackBar(context,
                        "por favor selecione Quantidade de Aulas primeiro");
                    return;
                  }

                  if (time.text.isEmpty) {
                    Functions.showSnackBar(
                        context, "Adicione o valor total primeiro");
                    return;
                  }

                  try {
                    if (!isValid()) {
                      Functions.showSnackBar(context,
                          "O instrutor não está disponível nesse momento.");
                      return;
                    }
                    Functions.showLoading(context);

                    DocumentReference doc = Constants.bookings.doc();

                    String location = await getCity();

                    int totalCl = int.parse(selectedClasses!);
                    BookingModel booking = BookingModel(
                        id: doc.id,
                        date: selectedDate,
                        amount: double.parse(amount.text),
                        instructorID: instructor.uid,
                        totalClasses: totalCl,
                        userID: Constants.uid(),
                        location: location);

                    await doc.set(booking.toMap());

                    UserModel user = context.read<DataProvider>().userModel!;

                    Functions.sendNotification(
                      NotificationModel(
                          metaData: booking.toMap(),
                          text: "${user.name} solicita aulas",
                          type: "booking",
                          time: DateTime.now().millisecondsSinceEpoch,
                          isRead: false),
                      instructor.uid,
                    );

                    context.pop(rootNavigator: true);

                    setState(() {
                      sentMessage = true;
                    });
                  } on FirebaseException catch (e) {
                    context.pop(rootNavigator: true);
                    Functions.showSnackBar(context, "algo aconteceu");
                    print(e);
                  }
                })
          ],
        ),
      ),
    );
  }

  bool isValid() {
    bool isValid = true;

    int selectedStartTimeI = int.parse(time.text.split(":")[0]);
    int selectedEndTimeI = selectedStartTimeI + int.parse(selectedClasses!);

    int day = getDay(DateFormat("EEE").format(selectedDate));

    AvailabilityModel model = availability[day];

    if (model.isAvailable) {
      if (model.startTime.text.isEmpty) {
        isValid = false;
      } else if (model.startTime.text.isNotEmpty) {
        int startTimeI = int.parse(model.startTime.text.split(":")[0]);

        if (model.endTime.text.isNotEmpty) {
          int endTimeI = int.parse(model.endTime.text.split(":")[0]);

          if (model.breakStart.text.isEmpty || model.breakEnd.text.isEmpty) {
            if (!(selectedStartTimeI >= startTimeI &&
                selectedEndTimeI <= endTimeI)) {
              isValid = false;
            }
          } else {
            int breakStartTimeI =
                int.parse(model.breakStart.text.split(":")[0]);
            int breakEndTimeI = int.parse(model.breakEnd.text.split(":")[0]);
            if ((selectedStartTimeI >= startTimeI &&
                    selectedStartTimeI <= breakStartTimeI &&
                    selectedEndTimeI <= breakStartTimeI) ||
                (selectedStartTimeI >= breakEndTimeI &&
                    selectedStartTimeI <= endTimeI &&
                    selectedEndTimeI <= endTimeI)) {
            } else {
              isValid = false;
            }
          }
        } else {
          if (selectedStartTimeI < startTimeI) {
            isValid = false;
          }
        }
      }
    } else {
      isValid = false;
    }
    return isValid;
  }

  int getDay(String day) {
    int index = 0;
    switch (day) {
      case "Mon":
        index = 0;
        break;
      case "Tue":
        index = 1;
        break;
      case "Wed":
        index = 2;
        break;
      case "Thu":
        index = 3;
        break;
      case "Fri":
        index = 4;
        break;
      case "Sat":
        index = 5;
        break;
      case "Sun":
        index = 6;
        break;
    }

    return index;
  }

  Widget timeField() {
    return InkWell(
      onTap: () {
        var duration = time.text.trim().isEmpty
            ? Duration()
            : Duration(
                hours: int.tryParse(time.text.split(":").first) ?? 0,
                minutes: int.tryParse(time.text.split(":").last) ?? 0);
        showCupertinoModalPopup<void>(
            context: context,
            builder: (BuildContext context) {
              return Center(
                child: Container(
                  height: 200,
                  width: 300,
                  color: Colors.white,
                  child: CTimerPicker(
                      duration: duration,
                      onTimerDurationChanged: (changeTimer) {
                        var hours = changeTimer.inHours;
                        var mins = changeTimer.inMinutes % 60;
                        selectedDate = DateTime(selectedDate.year,
                            selectedDate.month, selectedDate.day, hours, mins);
                        time.text =
                            '${hours < 10 ? "0$hours" : hours}:${mins < 10 ? "0$mins" : mins}';
                      }),
                ),
              );
            });
      },
      child: TextFieldWidget(
        enabled: false,
        controller: time,
        borderColor: CColors.textFieldBorder,
        label: "Horário",
        suffixIcon: const Icon(Icons.keyboard_arrow_down),
      ),
    );
  }

  Widget confirmMessage() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              setState(() {
                sentMessage = false;
              });
            },
            child: Container(
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
          ),
          Text(
            "Sua solicitação de aula foi enviada",
            style: AppTextStyles.subTitleMedium(size: 16),
          ),
          const MarginWidget(),
          Text(
            textAlign: TextAlign.center,
            "Quando o instrutor confirmar sua aula, você receberá uma notificação",
            style: AppTextStyles.captionMedium(size: 14),
          )
        ],
      ),
    );
  }

  Future<String> getCity() async {
    DataProvider dataProvider = context.read<DataProvider>();
    String location = "";

    try {
      location = await Functions.getAddressFromLatLng(
          dataProvider.latitude!, dataProvider.longitude!);
    } catch (e) {
      print('Error getting location: $e');
    }

    return location;
  }
}
