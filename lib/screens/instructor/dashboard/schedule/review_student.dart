import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:projeto/extras/app_assets.dart';
import 'package:projeto/extras/app_textstyles.dart';
import 'package:projeto/extras/colors.dart';
import 'package:projeto/extras/functions.dart';
import 'package:projeto/model/booking_model.dart';
import 'package:projeto/model/user_model.dart';
import 'package:utility_extensions/utility_extensions.dart';
import 'package:projeto/widgets/button_widget.dart';
import 'package:projeto/widgets/custom_asset_image.dart';
import 'package:projeto/widgets/margin_widget.dart';
import 'package:projeto/widgets/textfield_widget.dart';
import 'package:intl/intl.dart';

import '../../../../extras/constants.dart';
import '../../../../model/review_model.dart';
import '../../../dashboard/reviews/review_success.dart';

class ReviewStudent extends StatefulWidget {
  const ReviewStudent({Key? key, required this.user, required this.bookingModel})
      : super(key: key);

  final UserModel user;
  final BookingModel bookingModel;

  @override
  State<ReviewStudent> createState() => _ReviewStudentState();
}

class _ReviewStudentState extends State<ReviewStudent> {
  late double width, padding;

  double studentR = 1;
  TextEditingController opinionC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    width = context.width;
    padding = width * 0.04;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Avaliação de Progresso",
          style: AppTextStyles.subTitleMedium(),
        ),
      ),
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
                    child: widget.user.image != null
                        ? Image(
                            image: NetworkImage(widget.user.image!),
                            fit: BoxFit.cover,
                          )
                        : CustomAssetImage(
                            path: AppImages.demo,
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
                const MarginWidget(),
                Text(
                  "${widget.user.name}",
                  style: AppTextStyles.titleMedium(),
                ),
                const MarginWidget(),
                Text(
                  "Data: ${DateFormat("dd-MM-yyyy").format(widget.bookingModel.date)}",
                  style: AppTextStyles.captionMedium(),
                ),
                Text(
                  "Horário:  ${widget.bookingModel.time}",
                  style: AppTextStyles.captionMedium(),
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
                      "Qual sua avaliação sobre a performance do aluno?",
                      style: AppTextStyles.subTitleRegular(),
                    ),
                    const MarginWidget(),
                    rating(studentR, (rating) {
                      studentR = rating;
                    }),
                    const MarginWidget(),
                    Text(
                      "Escreva sua percepção sobre a aula",
                      style: AppTextStyles.subTitleMedium(),
                    ),
                    const MarginWidget(),
                    TextFieldWidget(
                      controller: opinionC,
                      hint: '',
                      maxLines: 5,
                    ),
                    const MarginWidget(factor: 2),
                    ButtonWidget(
                        name: "Enviar",
                        onPressed: () async {
                          if (opinionC.text.isEmpty) {
                            Functions.showSnackBar(
                                context, "Por favor insira sua opinião");
                            return;
                          }

                          try {
                            ReviewModel model = ReviewModel(
                              instructorID: Constants.uid(),
                              date: DateTime.now(),
                              time: widget.bookingModel.time,
                              totalR: studentR,
                              opinion: opinionC.text,
                            );

                            UserModel updated = widget.user;
                            updated.reviews.add(model);

                            Functions.showLoading(context);

                            await Constants.users.doc(updated.uid).update({
                              "reviews": updated.reviews
                                  .map((e) => e.toMap())
                                  .toList(),
                            });

                            await Constants.bookings
                                .doc(widget.bookingModel.id)
                                .update({
                              "studentRating": true,
                            });

                            context.pop(rootNavigator: true);

                            context.pushReplacement(
                                child: const ReviewSuccess());
                          } on FirebaseException catch (e) {
                            print(e);
                          }
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

  Widget rating(double rating, void Function(double) onUpdate) {
    return RatingBar.builder(
      itemSize: 30,
      initialRating: rating,
      minRating: 1,
      direction: Axis.horizontal,
      allowHalfRating: false,
      itemCount: 5,
      itemPadding: const EdgeInsets.symmetric(horizontal: 1.0),
      itemBuilder: (context, _) => const Icon(
        Icons.star,
        size: 10,
        color: Colors.amber,
      ),
      onRatingUpdate: onUpdate,
    );
  }
}
