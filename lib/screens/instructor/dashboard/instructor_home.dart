import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:projeto/widgets/my_cars_widget.dart';
import 'package:utility_extensions/utility_extensions.dart';
import 'package:projeto/generated/assets.dart';
import 'package:utility_extensions/extensions/font_utilities.dart';

import '../../../extras/app_assets.dart';
import '../../../extras/app_textstyles.dart';
import '../../../extras/colors.dart';
import '../../../extras/functions.dart';
import '../../../widgets/custom_text.dart';
import '../../../widgets/margin_widget.dart';

class InstructorHome extends StatefulWidget {
  const InstructorHome({super.key});

  @override
  State<InstructorHome> createState() => _InstructorHomeState();
}

class _InstructorHomeState extends State<InstructorHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CColors.dashboard,
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
            ratingWidget(),
            carsWidget(),
            TextButton(
              onPressed: () {},
              child: Text(
                "Gerenciar carros",
                style: AppTextStyles.poppins(
                    style: TextStyle(
                  color: CColors.primary,
                  fontSize: 12,
                  fontWeight: FontWeights.medium,
                )),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget ratingWidget() {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          20,
        ),
      ),
      margin: const EdgeInsets.all(
        20,
      ),
      child: Container(
        margin: const EdgeInsets.all(
          20,
        ),
        width: double.infinity,
        child: Column(
          children: [
            Text(
              "Sua avaliação",
              style: AppTextStyles.poppins(
                  style: TextStyle(
                color: CColors.textColor,
                fontSize: 16,
              )),
            ),
            MarginWidget(),
            RatingBarIndicator(
              rating: 2.75,
              itemBuilder: (context, index) => Icon(
                Icons.star,
                color: CColors.rating,
              ),
              itemCount: 5,
              itemSize: 21.0,
              direction: Axis.horizontal,
            ),
            const MarginWidget(
              factor: 0.5,
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                "Ver todas as avaliações",
                style: AppTextStyles.poppins(
                    style: TextStyle(
                  color: CColors.primary,
                  fontSize: 12,
                  fontWeight: FontWeights.medium,
                )),
              ),
            ),
          ],
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
                      text: "Próxima aula",
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    const MarginWidget(
                      factor: 0.3,
                    ),
                    CustomText(
                      text: "30 de junho 2023",
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
                "Ver aulas",
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
        Image(
          image: AssetImage(AppIcons.notification),
          color: CColors.black,
          width: 30,
        )
      ],
    );
  }

  Widget carsWidget() {
   return Padding(
     padding: const EdgeInsets.all(20.0),
     child: Column(
       children: [
         Text(
           "Seus Carros",
           style: AppTextStyles.subTitleMedium(),
         ),
         MyCarsWidget(),
       ],
     ),
   );
  }
}
