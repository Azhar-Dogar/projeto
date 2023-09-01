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

class ChatScreen extends StatefulWidget {
  ChatScreen({super.key,this.isInstructor});
bool? isInstructor;
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late double width, padding;

  @override
  Widget build(BuildContext context) {
    width = context.width;
    padding = width * 0.04;

    return Scaffold(
      appBar: CustomAppBar("Chat",isInstructor: widget.isInstructor),
      body: Padding(
        padding: EdgeInsets.only(left: padding, right: padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const MarginWidget(),
            Text(
              "Conversas",
              style: AppTextStyles.titleMedium(),
            ),
            chatHeader(),
            const DividerWidget(),
            chatHeader(),
            const DividerWidget(),
            chatHeader(),
            const DividerWidget(),
            const Expanded(child: SizedBox()),
            Text("Conversar com o suporte",style: AppTextStyles.captionMedium(color: CColors.primary),),
            const MarginWidget(),

          ],
        ),
      ),
    );
  }

  Widget chatHeader() {
    return InkWell(
      onTap: (){
        context.push(child:  InboxScreen(isInstructor: widget.isInstructor,));
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const MarginWidget(),
          Padding(
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 60,
                  width: 60,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: ClipOval(
                    child: CustomAssetImage(
                      path: AppImages.demo,
                      height: 60,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const MarginWidget(isHorizontal: true),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Annette Johnson",
                      style: AppTextStyles.subTitleMedium(),
                    ),
                    const MarginWidget(factor: 0.3),
                    Text(
                      "1 hora atrás",
                      style:
                          AppTextStyles.subTitleRegular(color: CColors.textFieldBorder),
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
}
