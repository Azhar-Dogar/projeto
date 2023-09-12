import 'package:flutter/material.dart';
import 'package:projeto/model/notification_model.dart';
import 'package:timeago_flutter/timeago_flutter.dart';

import '../extras/app_assets.dart';
import '../extras/app_textstyles.dart';
import '../extras/colors.dart';
import 'custom_asset_image.dart';
import 'margin_widget.dart';

class NotificationWidget extends StatelessWidget {
  const NotificationWidget({Key? key, required this.notification}) : super(key: key);

  final NotificationModel notification;
  @override
  Widget build(BuildContext context) {

    String path = "";
    switch(notification.type){
      case "chat":
        path = AppIcons.message;
        break;
      case "support":
        path = AppIcons.setting;
        break;
      case "documentApprove":
        path = AppIcons.approval;
        break;
      case "appointment":
        path = AppIcons.calendar;
        break;
    }
    return Column(
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
                    date: DateTime.fromMillisecondsSinceEpoch(notification.time),
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
    );
  }
}
