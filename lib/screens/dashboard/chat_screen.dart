import 'package:flutter/material.dart';
import 'package:projeto/extras/app_assets.dart';
import 'package:projeto/extras/app_textstyles.dart';
import 'package:projeto/extras/colors.dart';
import 'package:projeto/provider/data_provider.dart';
import 'package:projeto/widgets/chat_widget.dart';
import 'package:provider/provider.dart';
import 'package:utility_extensions/utility_extensions.dart';
import 'package:projeto/screens/dashboard/chat/chat_inbox.dart';
import 'package:projeto/widgets/custom_asset_image.dart';
import 'package:projeto/widgets/divider_widget.dart';
import 'package:projeto/widgets/margin_widget.dart';

import '../../widgets/c_profile_app_bar.dart';

class ChatScreen extends StatefulWidget {
  ChatScreen({super.key, this.isInstructor});

  bool? isInstructor;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late double width, padding;

  late DataProvider dataProvider;

  @override
  Widget build(BuildContext context) {
    width = context.width;
    padding = width * 0.04;

    return Consumer<DataProvider>(builder: (context, value, child) {
      dataProvider = value;
      return Scaffold(
        appBar: CustomAppBar("Chat", isInstructor: widget.isInstructor),
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
              Expanded(
                child: ListView.separated(
                  itemBuilder: (ctx, i) {
                    var chat = dataProvider.chats[i];
                    return ChatWidget(
                      chat: chat,
                      key: Key(chat.to),
                    );
                  },
                  separatorBuilder: (ctx, i) {
                    return const DividerWidget();
                  },
                  itemCount: dataProvider.chats.length,
                ),
              ),
              Text(
                "Conversar com o suporte",
                style: AppTextStyles.captionMedium(color: CColors.primary),
              ),
              const MarginWidget(),
            ],
          ),
        ),
      );
    });
  }
}
