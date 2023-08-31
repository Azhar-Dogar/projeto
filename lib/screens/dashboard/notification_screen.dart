import 'package:flutter/material.dart';
import 'package:projeto/extras/app_assets.dart';
import 'package:projeto/extras/app_textstyles.dart';
import 'package:projeto/extras/colors.dart';
import 'package:projeto/extras/extensions.dart';
import 'package:projeto/widgets/custom_asset_image.dart';
import 'package:projeto/widgets/divider_widget.dart';
import 'package:projeto/widgets/margin_widget.dart';

import '../../widgets/c_profile_app_bar.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  late double width, padding;

  @override
  Widget build(BuildContext context) {
    width = context.width;
    padding = width * 0.04;

    return Scaffold(
      appBar: CustomAppBar("Notificações"),
      body: Padding(
        padding: EdgeInsets.only(left: padding, right: padding),
        child: SingleChildScrollView(
          child: Column(
            children: [
              notificationRow(AppIcons.message),
              const DividerWidget(),
              notificationRow(AppIcons.message),
              const DividerWidget(),
              notificationRow(AppIcons.message),
              const DividerWidget(),
              notificationRow(AppIcons.setting),
              const DividerWidget(),
              notificationRow(AppIcons.approval),
              const DividerWidget(),
              notificationRow(AppIcons.calendar),
              const DividerWidget(),
            ],
          ),
        ),
      ),
    );
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
