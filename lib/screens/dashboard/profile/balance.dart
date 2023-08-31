import 'package:flutter/material.dart';
import 'package:projeto/extras/app_assets.dart';
import 'package:projeto/extras/app_textstyles.dart';
import 'package:projeto/extras/colors.dart';
import 'package:projeto/extras/extensions.dart';
import 'package:projeto/screens/dashboard/profile/widgets/prodileAppBar.dart';
import 'package:projeto/widgets/custom_asset_image.dart';
import 'package:projeto/widgets/divider_widget.dart';
import 'package:projeto/widgets/margin_widget.dart';

class Balance extends StatelessWidget {
  const Balance({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double padding = context.width * 0.04;

    return Scaffold(
      appBar: profileAppBar("Pagamento"),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.black,
        child: Column(
          children: [
            topWidget(),
            cardDetailSection(padding),
          ],
        ),
      ),
    );
  }

  Widget cardDetailSection(double padding) {
    return Expanded(
      child: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
          ),
        ),
        padding: EdgeInsets.only(left: padding, right: padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const MarginWidget(factor: 2),
            Text(
              "Cartões adicionados",
              style: AppTextStyles.subTitleMedium(),
            ),
            const MarginWidget(factor: 2),
            cardDetail(isPrinciple: true),
            const MarginWidget(),
            cardDetail(),
            const MarginWidget(factor: 2),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.add),
                const MarginWidget(isHorizontal: true),
                Text(
                  "Adicionar Cartão",
                  style: AppTextStyles.captionMedium(color: CColors.primary),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget cardDetail({bool isPrinciple = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "**** **** **** 1234",
                    style: AppTextStyles.captionMedium(),
                  ),
                  const MarginWidget(factor: 0.5),
                  Text(
                    "Crédito",
                    style: AppTextStyles.captionMedium(),
                  ),
                ],
              ),
            ),
            if (isPrinciple) principle(),
          ],
        ),
        const MarginWidget(factor: 0.7),
        const DividerWidget(),
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

  Widget topWidget() {
    return Column(
      children: [
        const MarginWidget(factor: 2.5),
        Text(
          "R\$ 800,00",
          style: AppTextStyles.h4Medium(color: Colors.white),
        ),
        const MarginWidget(),
        Text(
          "Crédito",
          style: AppTextStyles.titleMedium(
              color: Colors.white, weight: FontWeight.w400),
        ),
        const MarginWidget(),
        addCredit(),
        const MarginWidget(factor: 2.5),
      ],
    );
  }

  Widget addCredit() {
    return Container(
      width: 200,
      height: 40,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: CColors.primary, width: 2)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.add,
            color: CColors.primary,
          ),
          const MarginWidget(isHorizontal: true),
          Text(
            "Adicionar Crédito",
            style: AppTextStyles.captionMedium(color: CColors.primary),
          ),
        ],
      ),
    );
  }


}
