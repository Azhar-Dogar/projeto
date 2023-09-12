import 'package:flutter/material.dart';
import 'package:projeto/extras/app_textstyles.dart';
import 'package:projeto/extras/colors.dart';
import 'package:projeto/generated/assets.dart';
import 'package:projeto/widgets/c_rating_bar.dart';
import 'package:projeto/widgets/custom_asset_image.dart';
import 'package:projeto/widgets/divider_widget.dart';
import 'package:projeto/widgets/margin_widget.dart';
import 'package:utility_extensions/utility_extensions.dart';

class InstructorProgress extends StatelessWidget {
  const InstructorProgress({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double padding = context.width * 0.04;
    return Scaffold(
      appBar: appBar(),
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: [
            rating(),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(padding),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.separated(
                        padding : EdgeInsets.zero,
                        itemBuilder: (ctx, index) {
                          return ratingWidget();
                        },
                        itemCount: 3,
                        separatorBuilder: (BuildContext context, int index) {
                          return DividerWidget();
                        },
                      ),
                    ),
                    DividerWidget(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget ratingWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 26,
            backgroundImage: AssetImage(
              Assets.imagesDemo,
            ),
          ),
          const MarginWidget(isHorizontal: true),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Guy Hawkins",
                  style: AppTextStyles.subTitleMedium(),
                ),
                const MarginWidget(factor: 0.5),
                Text(
                  "Ótimo professor, muito calmo e educado.",
                  style: AppTextStyles.subTitleRegular(
                      color: CColors.textFieldBorder),
                ),
                const MarginWidget(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    individualRating("Instrutor", 3),
                    individualRating("Carro", 4),
                    individualRating("Percurso", 3),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Column individualRating(String text, double value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style: AppTextStyles.subTitleRegular(),
        ),
        const MarginWidget(factor: 0.3),
        CRatingBar(rating: value),
      ],
    );
  }

  Widget rating() {
    return Container(
      width: double.infinity,
      color: CColors.dashboard,
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(vertical: 44),
      child: CRatingBar(
        ignoreGesture: true,
        onUpdate: (value) {},
        rating: 4,
        itemSize: 26,
      ),
    );
  }

  AppBar appBar() {
    return AppBar(
      title: Text(
        "Avaliações",
        style: AppTextStyles.subTitleMedium(),
      ),
    );
  }
}
