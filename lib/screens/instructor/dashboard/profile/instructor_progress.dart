import 'package:flutter/material.dart';
import 'package:projeto/extras/app_textstyles.dart';
import 'package:projeto/extras/colors.dart';
import 'package:projeto/generated/assets.dart';
import 'package:projeto/model/review_model.dart';
import 'package:projeto/model/user_model.dart';
import 'package:projeto/provider/data_provider.dart';
import 'package:projeto/widgets/c_rating_bar.dart';
import 'package:projeto/widgets/custom_asset_image.dart';
import 'package:projeto/widgets/divider_widget.dart';
import 'package:projeto/widgets/margin_widget.dart';
import 'package:provider/provider.dart';
import 'package:utility_extensions/utility_extensions.dart';

class InstructorProgress extends StatefulWidget {
  const InstructorProgress({Key? key}) : super(key: key);

  @override
  State<InstructorProgress> createState() => _InstructorProgressState();
}

class _InstructorProgressState extends State<InstructorProgress> {
  late DataProvider dataProvider;

  @override
  Widget build(BuildContext context) {
    double padding = context.width * 0.04;
    return Consumer<DataProvider>(builder: (context, value, child) {
      dataProvider = value;
      return Scaffold(
        appBar: appBar(),
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            children: [
              rating(),
              displayReviews(padding),
            ],
          ),
        ),
      );
    });
  }

  Widget displayReviews(double padding) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.all(padding),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemBuilder: (ctx, index) {
                  return ratingWidget(dataProvider.userModel!.reviews[index]);
                },
                itemCount: dataProvider.userModel!.reviews.length,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget ratingWidget(ReviewModel model) {
    UserModel? userModel = dataProvider.getUserById(model.userID!);

    ImageProvider<Object>? avatarImage;

    if (userModel!.image != null) {
      avatarImage = NetworkImage(userModel.image!);
    } else {
      avatarImage = AssetImage(Assets.imagesDemo);
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(radius: 26, backgroundImage: avatarImage),
              const MarginWidget(isHorizontal: true),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${userModel.name}",
                      style: AppTextStyles.subTitleMedium(),
                    ),
                    const MarginWidget(factor: 0.5),
                    Text(
                      "${model.opinion}",
                      style: AppTextStyles.subTitleRegular(
                          color: CColors.textFieldBorder),
                    ),
                    const MarginWidget(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        individualRating(
                          "Instrutor",
                          model.instructorR!,
                        ),
                        individualRating("Carro", model.vehicleR!),
                        individualRating("Percurso", model.courseR!),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        DividerWidget(),
      ],
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
        CRatingBar(
          rating: value,
          ignoreGesture: true,
        ),
      ],
    );
  }

  Widget rating() {
    return Container(
      width: double.infinity,
      color: CColors.dashboard,
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(vertical: 44),
      child:

      CRatingBar(
        ignoreGesture: true,
        rating: dataProvider.totalRating,
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
