import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:projeto/extras/app_assets.dart';
import 'package:projeto/extras/app_textstyles.dart';
import 'package:projeto/extras/colors.dart';
import 'package:projeto/model/review_model.dart';
import 'package:projeto/model/user_model.dart';
import 'package:projeto/provider/data_provider.dart';
import 'package:provider/provider.dart';
import 'package:utility_extensions/utility_extensions.dart';
import 'package:projeto/widgets/custom_asset_image.dart';
import 'package:projeto/widgets/divider_widget.dart';
import 'package:projeto/widgets/margin_widget.dart';
import 'package:intl/intl.dart';

class MyProgress extends StatefulWidget {
  const MyProgress({Key? key}) : super(key: key);

  @override
  State<MyProgress> createState() => _MyProgressState();
}

class _MyProgressState extends State<MyProgress> {
  late double width, padding;

  TextEditingController reviewC = TextEditingController();

  late DataProvider provider;

  @override
  Widget build(BuildContext context) {
    width = context.width;
    padding = width * 0.04;

    return Consumer<DataProvider>(builder: (context, value, child) {
      provider = value;

      return Scaffold(
        appBar: AppBar(
          title: Text(
            "Meu Progresso",
            style: AppTextStyles.subTitleMedium(),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.only(left: padding + 20, right: padding + 20),
          child: Column(
            children: [
              Expanded(
                child: ListView.separated(
                    padding: EdgeInsets.zero,
                    itemBuilder: (ctx, index) {
                      return reviewWidget(provider.userModel!.reviews[index]);
                    },
                    separatorBuilder: (ctx, index) {
                      return const DividerWidget();
                    },
                    itemCount: provider.userModel!.reviews.length),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget reviewWidget(ReviewModel reviewModel) {

    UserModel? instructor = provider.getUserById(reviewModel.instructorID!);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const MarginWidget(),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: ClipOval(
                child: CustomAssetImage(
                  path: AppImages.demo,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const MarginWidget(isHorizontal: true),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${instructor!.name}",
                    style: AppTextStyles.subTitleMedium(),
                  ),
                  const MarginWidget(factor: 0.3),
                  Text(
                    "Data da aula: ${DateFormat("dd-MM-yyyy").format(reviewModel.date)}",
                    style: AppTextStyles.subTitleRegular(),
                  ),
                  const MarginWidget(factor: 0.3),
                  Text(
                    "Horário: ${reviewModel.time}",
                    style: AppTextStyles.subTitleRegular(),
                  ),
                  const MarginWidget(factor: 0.3),
                  Text(
                    "${reviewModel.opinion}",
                    style: AppTextStyles.subTitleRegular(
                        color: CColors.textFieldBorder),
                  ),
                  const MarginWidget(factor: 0.5),
                  Text(
                    "Percepção sobre o progresso",
                    style: AppTextStyles.subTitleRegular(),
                  ),
                  const MarginWidget(factor: 0.3),
                  rating(reviewModel.totalR),
                ],
              ),
            ),
          ],
        ),
        const MarginWidget(),
      ],
    );
  }

  Widget rating(double value) {
    return RatingBar.builder(
      ignoreGestures: true,
      itemSize: 28,
      initialRating: value,
      minRating: 1,
      direction: Axis.horizontal,
      allowHalfRating: false,
      itemCount: 5,
      updateOnDrag: false,
      itemPadding: const EdgeInsets.symmetric(horizontal: 1.0),
      itemBuilder: (context, _) => const Icon(
        Icons.star,
        size: 10,
        color: Colors.amber,
      ),
      onRatingUpdate: (rating) {},
    );
  }
}
