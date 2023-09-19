import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:projeto/generated/assets.dart';
import 'package:projeto/model/user_model.dart';
import 'package:projeto/provider/chat_provider.dart';
import 'package:projeto/provider/data_provider.dart';
import 'package:projeto/widgets/c_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:utility_extensions/utility_extensions.dart';
import '../extras/app_textstyles.dart';
import '../extras/colors.dart';
import '../extras/functions.dart';
import '../screens/dashboard/chat/chat_inbox.dart';
import '../screens/dashboard/home/scheduling.dart';
import 'button_widget.dart';
import 'margin_widget.dart';

class InstructorWidget extends StatelessWidget {
  const InstructorWidget(
      {super.key, this.toChoose, required this.user, this.onChoose});

  final bool? toChoose;
  final UserModel user;
  final Function(UserModel)? onChoose;

  @override
  Widget build(BuildContext context) {
    return Consumer<DataProvider>(builder: (context, value, child) {
      return Padding(
        padding: const EdgeInsets.all(12.0),
        child: Card(
          color: CColors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: CColors.dashboard,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image(
                        image: user.image == null
                            ? AssetImage(Assets.imagesPlaceHolder)
                            : NetworkImage(user.image!) as ImageProvider,
                        width: 30,
                      ),
                      const MarginWidget(
                        isHorizontal: true,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  user.name,
                                  style: AppTextStyles.subTitleMedium(),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(left: 12),
                                  decoration: BoxDecoration(
                                      color: CColors.primary,
                                      shape: BoxShape.circle),
                                  width: 15,
                                  height: 15,
                                )
                              ],
                            ),
                            // CRatingBar(rating: 3,itemSize: 18, onUpdate: (rating) {
                            //   print(rating);
                            // },),
                            RatingBar.builder(
                              ignoreGestures: true,
                              itemSize: 18,
                              initialRating: Functions.getRating(user),
                              minRating: 1,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemPadding:
                                  const EdgeInsets.symmetric(horizontal: 1.0),
                              itemBuilder: (context, _) => const Icon(
                                Icons.star,
                                size: 10,
                                color: Colors.amber,
                              ),
                              onRatingUpdate: (rating) {
                                print(rating);
                              },
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          context.push(
                            child: ChangeNotifierProvider(
                              create: (_) => ChatProvider(
                                  sender: value.userModel!, receiver: user),
                              child: InboxScreen(),
                            ),
                          );
                        },
                        child: Icon(
                          Icons.messenger_outline,
                          color: CColors.primary,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Divider(
                color: CColors.divider,
                height: 1,
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    info("Carro", "Celtic, 2018"),
                    Divider(
                      color: CColors.divider,
                      height: 1,
                    ),
                    info("Endereço", getAddress()),
                    Divider(
                      color: CColors.divider,
                      height: 1,
                    ),
                    info("Hora / Aula", "R\$ ${user.amount}"),
                    Divider(
                      color: CColors.divider,
                      height: 1,
                    ),
                    if (toChoose != null) ...[
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: ButtonWidget(
                            name: toChoose! ? "Escolher" : "Agendar",
                            onPressed: () {
                              if (toChoose!) {
                                onChoose!(user);
                              } else {
                                Functions.push(
                                    context,
                                    SchedulingScreen(
                                      instructor: user,
                                    ));
                              }
                            }),
                      )
                    ]
                  ],
                ),
              )
            ],
          ),
        ),
      );
    });
  }

  String getAddress() {
    return "${user.number},${user.neighbourhood},${user.road},${user.complement},${user.zipCode}";
  }

  Widget info(String name, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: AppTextStyles.captionRegular(),
          ),
          Text(
            value,
            style: AppTextStyles.captionRegular(size: 14),
          )
        ],
      ),
    );
  }
}
