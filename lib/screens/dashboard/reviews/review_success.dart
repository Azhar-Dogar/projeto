import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:projeto/extras/app_assets.dart';
import 'package:projeto/extras/app_textstyles.dart';
import 'package:projeto/extras/colors.dart';
import 'package:projeto/extras/extensions.dart';
import 'package:projeto/widgets/button_widget.dart';
import 'package:projeto/widgets/custom_asset_image.dart';
import 'package:projeto/widgets/margin_widget.dart';
import 'package:projeto/widgets/textfield_widget.dart';

import '../../../widgets/c_profile_app_bar.dart';

class ReviewSuccess extends StatefulWidget {
  const ReviewSuccess({Key? key}) : super(key: key);

  @override
  State<ReviewSuccess> createState() => _ReviewSuccessState();
}

class _ReviewSuccessState extends State<ReviewSuccess> {
  late double width, padding;

  TextEditingController reviewC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    width = context.width;
    padding = width * 0.04;

    return Scaffold(
      appBar: CustomAppBar("Avaliação"),
      body: Center(
        child: Padding(
          padding:  EdgeInsets.only(left: padding + 20, right: padding + 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              rating(),
              const MarginWidget(),
              Text(
                "Obrigada pela sua avaliação!",
                style: AppTextStyles.titleMedium(),
              ),
              const MarginWidget(),
              Text(
                textAlign: TextAlign.center,
                "Através dela conseguimos melhorar cada vez mais nossos serviços",
                style: AppTextStyles.subTitleRegular(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget rating() {
    return RatingBar.builder(
      itemSize: 60,
      initialRating: 3,
      minRating: 1,
      direction: Axis.horizontal,
      allowHalfRating: true,
      itemCount: 1,
      itemPadding: const EdgeInsets.symmetric(horizontal: 1.0),
      itemBuilder: (context, _) => const Icon(
        Icons.star,
        size: 10,
        color: Colors.amber,
      ),
      onRatingUpdate: (rating) {
        print(rating);
      },
    );
  }
}
