import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:projeto/extras/app_assets.dart';
import 'package:projeto/extras/app_textstyles.dart';
import 'package:projeto/extras/colors.dart';
import 'package:projeto/extras/constants.dart';
import 'package:projeto/extras/functions.dart';
import 'package:projeto/model/booking_model.dart';
import 'package:projeto/model/review_model.dart';
import 'package:projeto/model/user_model.dart';
import 'package:provider/provider.dart';
import 'package:utility_extensions/utility_extensions.dart';
import 'package:projeto/screens/dashboard/reviews/review_success.dart';
import 'package:projeto/widgets/button_widget.dart';
import 'package:projeto/widgets/custom_asset_image.dart';
import 'package:projeto/widgets/margin_widget.dart';
import 'package:projeto/widgets/textfield_widget.dart';
import '../../../provider/data_provider.dart';
import '../../../widgets/c_profile_app_bar.dart';

class ReviewInstructor extends StatefulWidget {
  const ReviewInstructor(
      {Key? key, required this.instructor, required this.bookingModel})
      : super(key: key);

  final UserModel instructor;
  final BookingModel bookingModel;

  @override
  State<ReviewInstructor> createState() => _ReviewInstructorState();
}

class _ReviewInstructorState extends State<ReviewInstructor> {
  late double width, padding;

  double instructorR = 1, vehicleR = 1, courseR = 1;
  TextEditingController opinionC = TextEditingController();

  ReviewModel? reviewModel;

  @override
  void initState() {
    super.initState();

    reviewModel = context
        .read<DataProvider>()
        .getUserById(widget.bookingModel.instructorID)!
        .reviews
        .where((element) => element.bookingID == widget.bookingModel.id)
        .firstOrNull;

    if (reviewModel != null) {
      instructorR = reviewModel!.instructorR!;
      vehicleR = reviewModel!.vehicleR!;
      courseR = reviewModel!.courseR!;
      opinionC.text = reviewModel!.opinion;
    }
  }

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
                    child: widget.instructor.image != null
                        ? Image(
                            image: NetworkImage(widget.instructor.image!),
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
                  "${widget.instructor.name}",
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
                    rating(instructorR, (rating) {
                      instructorR = rating;
                    }),
                    const MarginWidget(),
                    Text(
                      "Qual sua avaliação do veículo utilizado?",
                      style: AppTextStyles.subTitleRegular(),
                    ),
                    const MarginWidget(),
                    rating(vehicleR, (rating) {
                      vehicleR = rating;
                    }),
                    const MarginWidget(),
                    Text(
                      textAlign: TextAlign.center,
                      "Qual a sua avaliação sobre o percurso feito nas aulas?",
                      style: AppTextStyles.subTitleRegular(),
                    ),
                    const MarginWidget(),
                    rating(courseR, (rating) {
                      courseR = rating;
                    }),
                    const MarginWidget(factor: 1.5),
                    Text(
                      "Conte-nos mais sobre sua opinião:",
                      style: AppTextStyles.subTitleMedium(),
                    ),
                    const MarginWidget(),
                    TextFieldWidget(
                      enabled: reviewModel == null,
                      controller: opinionC,
                      hint: '',
                      maxLines: 5,
                    ),
                    const MarginWidget(factor: 2),
                    if (reviewModel == null) ...[
                      ButtonWidget(
                          name: "Enviar",
                          onPressed: () async {
                            if (opinionC.text.isEmpty) {
                              Functions.showSnackBar(
                                  context, "Por favor insira sua opinião");
                              return;
                            }

                            try {
                              double rating =
                                  (instructorR + vehicleR + courseR) / 3.0;
                              ReviewModel model = ReviewModel(
                                bookingID: widget.bookingModel.id,
                                userID: Constants.uid(),
                                date: DateTime.now(),
                                time: DateFormat("hh:mm a")
                                    .format(widget.bookingModel.date),
                                instructorR: instructorR,
                                vehicleR: vehicleR,
                                courseR: courseR,
                                totalR: rating,
                                opinion: opinionC.text,
                              );

                              Functions.showLoading(context);

                              UserModel updated = widget.instructor;
                              updated.reviews.add(model);

                              await Constants.users.doc(updated.uid).update({
                                "reviews": updated.reviews
                                    .map((e) => e.toMap())
                                    .toList()
                              });

                              await Constants.bookings
                                  .doc(widget.bookingModel.id)
                                  .update({
                                "instructorRating": true,
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
      ignoreGestures: reviewModel != null,
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
