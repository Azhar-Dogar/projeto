import 'package:flutter/material.dart';
import 'package:projeto/model/card_model.dart';
import 'package:projeto/provider/data_provider.dart';
import 'package:provider/provider.dart';
import 'package:utility_extensions/utility_extensions.dart';
import 'package:projeto/screens/dashboard/profile/credit/add_new_card.dart';
import '../../../../extras/app_assets.dart';
import '../../../../extras/app_textstyles.dart';
import '../../../../extras/colors.dart';
import '../../../../widgets/custom_asset_image.dart';
import '../../../../widgets/margin_widget.dart';

class CardDetail extends StatelessWidget {
  const CardDetail({Key? key, this.isEdit = false, required this.cardModel})
      : super(key: key);

  final bool isEdit;
  final CardModel cardModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, right: 4),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 45,
                width: 45,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: CColors.paymentContainer,
                ),
                alignment: Alignment.center,
                child: CustomAssetImage(
                  path: AppIcons.visa,
                  width: 24,
                ),
              ),
              const MarginWidget(isHorizontal: true),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          getCardNumber(),
                          style: AppTextStyles.captionMedium(),
                        ),
                        const MarginWidget(factor: 0.5),
                        Text(
                          cardModel.holderName,
                          style: AppTextStyles.captionMedium(),
                        ),
                      ],
                    ),
                    const MarginWidget(isHorizontal: true, factor: 1.5),
                    if (isEdit)
                      InkWell(
                        onTap: () {
                         context.push(child: AddNewCard(cardModel: cardModel,));
                        },
                        child: CustomAssetImage(
                          path: AppIcons.edit,
                          height: 20,
                          width: 20,
                        ),
                      )
                  ],
                ),
              ),
              if (cardModel.mainCard) principle(),
            ],
          ),
        ),
        const MarginWidget(factor: 0.7),
      ],
    );
  }

  Widget principle() {
    return Padding(
      padding: const EdgeInsets.only(left: 4, right: 4),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.only(top: 4, bottom: 4, left: 8, right: 8),
        child: Text(
          "Principal",
          style: AppTextStyles.captionRegular(color: Colors.white),
        ),
      ),
    );
  }

  String getCardNumber() {
    return "**** **** **** ${cardModel.number.substring(cardModel.number.length - 4)}";
  }
}
