import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../extras/app_textstyles.dart';
import '../extras/colors.dart';
import '../extras/functions.dart';
import '../screens/dashboard/home/scheduling.dart';
import 'button_widget.dart';
import 'margin_widget.dart';

class InstructorWidget extends StatelessWidget {
  InstructorWidget(
      {super.key,
      this.showButton,
      required this.name,
      required this.imagePath});
  String name;
  String imagePath;
  bool? showButton;
  @override
  Widget build(BuildContext context) {
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
                      image: AssetImage(imagePath),
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
                                name,
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
                          RatingBar.builder(
                            itemSize: 18,
                            initialRating: 3,
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
                          )
                        ],
                      ),
                    ),
                    Icon(
                      Icons.messenger_outline,
                      color: CColors.primary,
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
                  info("Car", "Celtic, 2018"),
                  Divider(
                    color: CColors.divider,
                    height: 1,
                  ),
                  info("Address", "105 William St, Chicago, US"),
                  Divider(
                    color: CColors.divider,
                    height: 1,
                  ),
                  info("Hora / Aula", "R\$ 80,00"),
                  Divider(
                    color: CColors.divider,
                    height: 1,
                  ),
                  if(showButton == true)...[
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: ButtonWidget(
                        name: "To schedule",
                        onPressed: () {
                          Functions.push(context, SchedulingScreen());
                        }),
                  )]
                ],
              ),
            )
          ],
        ),
      ),
    );
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
