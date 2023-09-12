import 'package:flutter/material.dart';
import 'package:projeto/extras/app_assets.dart';
import 'package:projeto/extras/app_textstyles.dart';
import 'package:projeto/extras/colors.dart';
import 'package:projeto/provider/data_provider.dart';
import 'package:projeto/widgets/notification_widget.dart';
import 'package:provider/provider.dart';
import 'package:utility_extensions/utility_extensions.dart';
import 'package:projeto/widgets/button_widget.dart';
import 'package:projeto/widgets/custom_asset_image.dart';
import 'package:projeto/widgets/divider_widget.dart';
import 'package:projeto/widgets/margin_widget.dart';

import '../../widgets/c_profile_app_bar.dart';

class NotificationScreen extends StatefulWidget {
  NotificationScreen({super.key, this.isInstructor});

  bool? isInstructor;

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  late double width, padding;

  @override
  Widget build(BuildContext context) {
    width = context.width;
    padding = width * 0.04;

    return Consumer<DataProvider>(builder: (context, data, child) {
      return Scaffold(
        appBar: CustomAppBar("Notificações", isInstructor: widget.isInstructor),
        body: Padding(
          padding: EdgeInsets.only(left: padding, right: padding),
          child: ListView.separated(
            itemBuilder: (ctx, i) {
              return NotificationWidget(notification: data.notifications[i]);
            },
            separatorBuilder: (ctx, i) {
              return const DividerWidget();
            },
            itemCount: data.notifications.length,
          ),

          // SingleChildScrollView(
          //   child: Column(
          //     children: [
          //       notificationRow(AppIcons.message),
          //       const DividerWidget(),
          //       notificationRow(AppIcons.message),
          //       const DividerWidget(),
          //       notificationRow(AppIcons.message),
          //       const DividerWidget(),
          //       notificationRow(AppIcons.setting),
          //       const DividerWidget(),
          //       notificationRow(AppIcons.approval),
          //       const DividerWidget(),
          //       InkWell(
          //         onTap: (){
          //           showDialog(context: context, builder: (BuildContext context){
          //             return requestsLessonDialogue(context);
          //           });
          //         },
          //         child: notificationRow(AppIcons.calendar),
          //       ),
          //       const DividerWidget(),
          //     ],
          //   ),
          // ),
        ),
      );
    });
  }

  Widget notificationRow(String path) {
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
                    "Annette Johnson enviou uma mensagem",
                    style: AppTextStyles.captionRegular(),
                  ),
                  const MarginWidget(factor: 0.5),
                  Text(
                    "1 hora atrás",
                    style: AppTextStyles.captionRegular(
                        color: CColors.textFieldBorder),
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
