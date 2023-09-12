import 'package:flutter/material.dart';
import 'package:projeto/model/chat_model.dart';
import 'package:projeto/provider/chat_provider.dart';
import 'package:projeto/provider/data_provider.dart';
import 'package:provider/provider.dart';
import 'package:utility_extensions/utility_extensions.dart';
import 'package:timeago/timeago.dart';
import 'package:timeago_flutter/timeago_flutter.dart';

import '../extras/app_textstyles.dart';
import '../extras/colors.dart';
import '../generated/assets.dart';
import '../screens/dashboard/chat/chat_inbox.dart';
import 'margin_widget.dart';

class ChatWidget extends StatelessWidget {
  const ChatWidget({Key? key, required this.chat}) : super(key: key);

  final ChatModel chat;

  @override
  Widget build(BuildContext context) {
    return Consumer<DataProvider>(
      builder: (context, value, child) {
        var instructor = value.users.where((element) => element.uid == chat.to);
        return InkWell(
          onTap: () {
            context.push(
              child: ChangeNotifierProvider(
                create: (_)=> ChatProvider(sender: value.userModel!, receiver: instructor.first),
                child: InboxScreen(),
              ),
            );
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
                        child: Image(
                          fit: BoxFit.cover,
                          image: chat.image == null
                              ? AssetImage(Assets.imagesPlaceHolder)
                              : NetworkImage(chat.image!) as ImageProvider,
                        ),
                      ),
                    ),
                    const MarginWidget(isHorizontal: true),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          chat.name,
                          style: AppTextStyles.subTitleMedium(),
                        ),
                        const MarginWidget(factor: 0.3),
                        Timeago(
                          builder: (_, value) {
                            return Text(
                              value,
                              style: AppTextStyles.subTitleRegular(
                                  color: CColors.textFieldBorder),
                            );
                          },
                          date: DateTime.fromMillisecondsSinceEpoch(chat.time),
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
    );
  }
}
