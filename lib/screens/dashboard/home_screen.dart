import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:projeto/extras/app_assets.dart';
import 'package:projeto/extras/app_textstyles.dart';
import 'package:projeto/extras/extensions.dart';
import 'package:projeto/widgets/button_widget.dart';
import 'package:projeto/widgets/custom_text.dart';
import 'package:projeto/widgets/margin_widget.dart';
import 'package:projeto/widgets/textfield_widget.dart';

import '../../extras/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const MarginWidget(
              factor: 2,
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: header(),
            ),
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Image(image: AssetImage(AppImages.autoImage)),
                ),
                Positioned(bottom: 1, left: 5, right: 5, child: card()),
              ],
            ),
            const MarginWidget(),
            Text(
              "Search instructors near me",
              style: AppTextStyles.captionMedium(color: CColors.primary),
            ),
            searchBar(),
            instructor("Annette Johnson",AppImages.instructor),
            MarginWidget(),
            instructor("Jacob Jones", AppImages.instructor_1)
          ],
        ),
      ),
    );
  }

  Widget instructor(String name,String imagePath) {
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
                                    color: CColors.primary, shape: BoxShape.circle),
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
                            itemPadding: const EdgeInsets.symmetric(horizontal: 1.0),
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
                    Icon(Icons.messenger_outline,color: CColors.primary,)
                  ],
                ),
              ),
            ),
            Divider(color: CColors.divider,height: 1,),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
               info("Car", "Celtic, 2018"),
                  Divider(color: CColors.divider,height: 1,),
                  info("Address", "105 William St, Chicago, US"),
                  Divider(color: CColors.divider,height: 1,),
                  info("Hora / Aula", "R\$ 80,00"),
                  Divider(color: CColors.divider,height: 1,),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: ButtonWidget(name: "To schedule", onPressed: (){}),
                  )
              ],),
            )
          ],
        ),
      ),
    );
  }
  Widget info(String name,String value){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Text(name,style: AppTextStyles.captionRegular(),),
        Text(value,style: AppTextStyles.captionRegular(size: 14),)
      ],),
    );
  }
  Widget searchBar() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12), color: CColors.dashboard),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: TextFieldWidget(
          fontSize: 12,
          hint: "Search instructors near me",
          prefixWidget: Icon(
            Icons.search,
            color: CColors.textFieldBorder,
          ),
          controller: searchController,
          borderColor: CColors.dashboard,
        ),
      ),
    );
  }

  Widget card() {
    return SizedBox(
      width: context.width,
      // margin: const EdgeInsets.only(right: 5),
      child: Card(
        color: CColors.white,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image(
                image: AssetImage(AppImages.clock),
                width: 60,
              ),
              const MarginWidget(
                isHorizontal: true,
                factor: 1.5,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: "Next Class",
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    const MarginWidget(
                      factor: 0.3,
                    ),
                    CustomText(
                      text: "June 30, 2023",
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                    const MarginWidget(
                      factor: 0.3,
                    ),
                    CustomText(
                      text: "10:20",
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                ),
              ),
              Text(
                "see classes",
                style:
                    AppTextStyles.captionMedium(color: CColors.textFieldBorder),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget header() {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CircleAvatar(
            radius: 20, backgroundImage: AssetImage(AppImages.profile)),
        const MarginWidget(
          isHorizontal: true,
        ),
        Expanded(
            child: CustomText(
          text: "Claudia\nsilva",
          fontSize: 12,
          fontWeight: FontWeight.w500,
        )),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: "Credit",
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
              CustomText(
                text: "R\$ 800,00",
                fontSize: 14,
                fontWeight: FontWeight.w500,
                textColor: CColors.primary,
              )
            ],
          ),
        ),
        const MarginWidget(
          factor: 5,
          isHorizontal: true,
        ),
        Image(
          image: AssetImage(AppIcons.notification),
          color: CColors.black,
          width: 30,
        )
      ],
    );
  }
}
