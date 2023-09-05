import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:projeto/extras/app_assets.dart';
import 'package:projeto/extras/app_textstyles.dart';
import 'package:projeto/extras/colors.dart';
import 'package:projeto/provider/data_provider.dart';
import 'package:provider/provider.dart';
import 'package:utility_extensions/utility_extensions.dart';
import 'package:projeto/widgets/custom_asset_image.dart';
import 'package:projeto/widgets/divider_widget.dart';
import 'package:projeto/widgets/margin_widget.dart';

class MeuProgresso extends StatefulWidget {
  const MeuProgresso({Key? key}) : super(key: key);

  @override
  State<MeuProgresso> createState() => _MeuProgressoState();
}

class _MeuProgressoState extends State<MeuProgresso> {
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
          child: SingleChildScrollView(
            child: Column(
              children: [
                reviewWidget(),
                const DividerWidget(),
                reviewWidget(),
                const DividerWidget(),
                reviewWidget(),
                const DividerWidget(),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget reviewWidget() {
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
                    "Annette Johnson",
                    style: AppTextStyles.subTitleMedium(),
                  ),
                  const MarginWidget(factor: 0.3),
                  Text(
                    "Data da aula: 15-06-2023",
                    style: AppTextStyles.subTitleRegular(),
                  ),
                  const MarginWidget(factor: 0.3),
                  Text(
                    "Horário: 10h00",
                    style: AppTextStyles.subTitleRegular(),
                  ),
                  const MarginWidget(factor: 0.3),
                  Text(
                    "Hoje tivemos uma grande evolução na aula.",
                    style: AppTextStyles.subTitleRegular(
                        color: CColors.textFieldBorder),
                  ),
                  const MarginWidget(factor: 0.5),
                  Text(
                    "Percepção sobre o progresso",
                    style: AppTextStyles.subTitleRegular(),
                  ),
                  const MarginWidget(factor: 0.3),
                  rating(),
                ],
              ),
            ),
          ],
        ),
        const MarginWidget(),
      ],
    );
  }

  Widget rating() {
    return RatingBar.builder(
      itemSize: 28,
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
