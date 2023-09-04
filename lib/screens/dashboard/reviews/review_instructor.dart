import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:projeto/extras/app_assets.dart';
import 'package:projeto/extras/app_textstyles.dart';
import 'package:projeto/extras/colors.dart';
import 'package:utility_extensions/utility_extensions.dart';
import 'package:projeto/screens/dashboard/reviews/review_success.dart';
import 'package:projeto/widgets/button_widget.dart';
import 'package:projeto/widgets/custom_asset_image.dart';
import 'package:projeto/widgets/margin_widget.dart';
import 'package:projeto/widgets/textfield_widget.dart';

import '../../../widgets/c_profile_app_bar.dart';

class ReviewInstructor extends StatefulWidget {
  const ReviewInstructor({Key? key}) : super(key: key);

  @override
  State<ReviewInstructor> createState() => _ReviewInstructorState();
}

class _ReviewInstructorState extends State<ReviewInstructor> {
  late double width, padding;

  TextEditingController reviewC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    width = context.width;
    padding = width * 0.04;

    return Scaffold(
      appBar: CustomAppBar("Avaliação"),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            color: CColors.dashboard,
            padding: const EdgeInsets.only(top: 36, bottom: 36),
            child: Column(
              children: [
                Container(
                  height: 90,
                  width: 90,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: CColors.primary, width: 4),
                  ),
                  child: ClipOval(
                    child: CustomAssetImage(
                      path: AppImages.demo,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const MarginWidget(),
                Text(
                  "Annette Johnson",
                  style: AppTextStyles.titleMedium(),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: padding, right: padding),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const MarginWidget(),
                    Text(
                      "Qual sua avaliação sobre o instrutor?",
                      style: AppTextStyles.subTitleRegular(),
                    ),
                    const MarginWidget(),
                    rating(),
                    const MarginWidget(),
                    Text(
                      "Qual sua avaliação do veículo utilizado?",
                      style: AppTextStyles.subTitleRegular(),
                    ),
                    const MarginWidget(),
                    rating(),
                    const MarginWidget(),
                    Text(
                      textAlign: TextAlign.center,
                      "Qual a sua avaliação sobre o percurso feito nas aulas?",
                      style: AppTextStyles.subTitleRegular(),
                    ),
                    const MarginWidget(),
                    rating(),
                    const MarginWidget(factor: 1.5),
                    Text(
                      "Conte-nos mais sobre sua opinião:",
                      style: AppTextStyles.subTitleMedium(),
                    ),
                    const MarginWidget(),
                    TextFieldWidget(controller: reviewC, hint: '', maxLines: 5,),
                    const MarginWidget(factor: 2),
                    ButtonWidget(name: "Enviar", onPressed: (){
                      context.push(child: const ReviewSuccess());
                    }),
                    const MarginWidget(),

                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget rating() {
    return RatingBar.builder(
      itemSize: 30,
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
    );
  }
}
