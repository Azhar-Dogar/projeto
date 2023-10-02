import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:projeto/extras/constants.dart';
import 'package:projeto/extras/functions.dart';
import 'package:projeto/model/booking_model.dart';
import 'package:projeto/model/notification_model.dart';
import 'package:projeto/model/user_model.dart';
import 'package:projeto/provider/data_provider.dart';
import 'package:provider/provider.dart';
import 'package:timeago_flutter/timeago_flutter.dart';
import 'package:utility_extensions/extensions/context_extensions.dart';

import '../extras/app_assets.dart';
import '../extras/app_textstyles.dart';
import '../extras/colors.dart';
import 'button_widget.dart';
import 'custom_asset_image.dart';
import 'margin_widget.dart';

class NotificationWidget extends StatelessWidget {
  const NotificationWidget({Key? key, required this.notification})
      : super(key: key);

  final NotificationModel notification;

  @override
  Widget build(BuildContext context) {

    if(!notification.isRead){

    }
    bool isBooking = false;
    String path = "";
    switch (notification.type) {
      case "chat":
        path = AppIcons.message;
        break;
      case "support":
        path = AppIcons.setting;
        break;
      case "documentApprove":
        path = AppIcons.approval;
        break;
      case "booking":
        isBooking = true;
        path = AppIcons.calendar;
        break;
    }
    return InkWell(
      onTap: isBooking
          ? () {
              BookingModel bookingModel =
                  BookingModel.fromMap(notification.metaData!);
              BookingModel? updatedBooking =
                  context.read<DataProvider>().getbookingById(bookingModel.id);
              if (updatedBooking!.status == "pending") {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return requestsLessonDialogue(context);
                    });
              }
            }
          : null,
      child: Column(
        children: [
          const MarginWidget(),
          Padding(
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: Row(
              children: [
                CustomAssetImage(
                  path: path,
                  height: 24,
                  color: Colors.black,
                ),
                const MarginWidget(isHorizontal: true),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      notification.text,
                      style: AppTextStyles.captionRegular(),
                    ),
                    const MarginWidget(factor: 0.5),
                    Timeago(
                      builder: (_, value) {
                        return Text(
                          value,
                          style: AppTextStyles.subTitleRegular(
                              color: CColors.textFieldBorder),
                        );
                      },
                      date: DateTime.fromMillisecondsSinceEpoch(
                          notification.time),
                      locale: "pt",
                      allowFromNow: true,
                    ),
                  ],
                ),
              ],
            ),
          ),
          const MarginWidget(),
        ],
      ),
    );
  }

  Widget requestsLessonDialogue(BuildContext context) {
    BookingModel bookingModel = BookingModel.fromMap(notification.metaData!);
    UserModel? userModel =
        context.read<DataProvider>().getUserById(bookingModel.userID);

    return AlertDialog(
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
                onPressed: () {
                  context.pop();
                },
                icon: const Icon(Icons.close)),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "${userModel!.name} solicita aulas",
                style: AppTextStyles.subTitleMedium(),
              ),
            ],
          ),
          const MarginWidget(),
          Text(
            "Localização: ${bookingModel.location}",
            style: AppTextStyles.subTitleRegular(),
          ),
          Text(
            "Data: ${DateFormat("dd-MM-yyyy").format(bookingModel.date)}",
            style: AppTextStyles.subTitleRegular(),
          ),
          Text(
            "Horário: ${Functions.formatTime(bookingModel.date)}",
            style: AppTextStyles.subTitleRegular(),
          ),
          Text(
            "Quantidade de aulas: ${bookingModel.totalClasses}",
            style: AppTextStyles.subTitleRegular(),
          ),
          const MarginWidget(
            factor: 2,
          ),
          Row(
            children: [
              Expanded(
                child: TextButton(
                  onPressed: () {
                    try {
                      Constants.bookings.doc(bookingModel.id).update({
                        "status": "denied",
                      });
                      context.pop();
                    } on FirebaseException catch (e) {
                      print(e);
                    }
                  },
                  child: Text(
                    "Rejeitar",
                    style: AppTextStyles.captionMedium(
                        size: 12, color: CColors.primary),
                  ),
                ),
              ),
              const MarginWidget(
                isHorizontal: true,
                factor: 2,
              ),
              Expanded(
                  child: ButtonWidget(
                      name: "Aceitar",
                      onPressed: () {
                        try {
                          Constants.bookings.doc(bookingModel.id).update({
                            "status": "confirmed",
                          });
                          context.pop();
                        } on FirebaseException catch (e) {
                          print(e);
                        }
                      }))
            ],
          )
        ],
      ),
    );
  }
}
