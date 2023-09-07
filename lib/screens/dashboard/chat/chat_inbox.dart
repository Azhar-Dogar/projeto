import 'package:flutter/material.dart';
import 'package:projeto/extras/app_assets.dart';
import 'package:projeto/extras/app_textstyles.dart';
import 'package:projeto/extras/colors.dart';
import 'package:projeto/extras/constants.dart';
import 'package:projeto/generated/assets.dart';
import 'package:projeto/provider/chat_provider.dart';
import 'package:projeto/provider/data_provider.dart';
import 'package:provider/provider.dart';
import 'package:utility_extensions/utility_extensions.dart';
import 'package:projeto/widgets/custom_asset_image.dart';
import 'package:projeto/widgets/margin_widget.dart';
import 'package:projeto/widgets/textfield_widget.dart';
import '../../../widgets/c_profile_app_bar.dart';
import '../../../widgets/chat_bubble_widget.dart';

class InboxScreen extends StatefulWidget {
  InboxScreen({super.key, this.isInstructor});

  bool? isInstructor;

  @override
  State<InboxScreen> createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen> {
  late double width, padding;

  @override
  Widget build(BuildContext context) {
    width = context.width;
    padding = width * 0.04;
    return Consumer<ChatProvider>(builder: (context, chat, child) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar("Chat", isInstructor: widget.isInstructor),
        body: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.white, boxShadow: Constants.shadow()),
              child: Padding(
                padding: EdgeInsets.only(left: padding, right: padding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const MarginWidget(),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Row(
                        children: [
                          Container(
                            height: 40,
                            width: 40,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: ClipOval(
                              child: Image(
                                image: chat.receiver.image == null ?  AssetImage(Assets.imagesPlaceHolder) : NetworkImage(chat.receiver.image!) as ImageProvider,
                                height: 40,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const MarginWidget(isHorizontal: true),
                          Text(
                            chat.receiver.name,
                            style: AppTextStyles.subTitleMedium(),
                          )
                        ],
                      ),
                    ),
                    const MarginWidget(),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                color: CColors.dashboard,
                padding: EdgeInsets.symmetric(horizontal: padding, vertical: 10, ),
                child: ListView.builder(
                  reverse:  true,
                  itemBuilder: (ctx, i) {
                    var message = chat.messages[i];
                    return ChatBubbleWidget(message: message, key: Key(message.id),);
                  },
                  itemCount: chat.messages.length,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: padding, right: padding),
              child: Container(
                height: 80,
                width: double.infinity,
                color: Colors.white,
                child: Row(
                  children: [
                    Expanded(
                      child: TextFieldWidget(
                        height: 50,
                        controller: chat.messageController,
                        hint: 'Escreva a mensagem',
                      ),
                    ),
                    const MarginWidget(
                      isHorizontal: true,
                    ),
                    InkWell(
                      onTap: () {
                        chat.sendMessage("text", null);
                      },
                      child: CustomAssetImage(
                        path: AppIcons.send,
                        height: 24,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      );
    });
  }
}
