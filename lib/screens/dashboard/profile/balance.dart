import 'package:flutter/material.dart';
import 'package:projeto/extras/app_assets.dart';
import 'package:projeto/extras/app_textstyles.dart';
import 'package:projeto/extras/colors.dart';
import 'package:projeto/extras/extensions.dart';
import 'package:projeto/extras/functions.dart';
import 'package:projeto/screens/dashboard/profile/add_balance.dart';
import 'package:projeto/screens/dashboard/profile/widgets/card_detail.dart';
import 'package:projeto/widgets/c_profile_app_bar.dart';
import 'package:projeto/widgets/custom_asset_image.dart';
import 'package:projeto/widgets/divider_widget.dart';
import 'package:projeto/widgets/margin_widget.dart';

class Balance extends StatelessWidget {
  const Balance({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double padding = context.width * 0.04;

    return Scaffold(
      appBar: CustomAppBar("Pagamento"),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.black,
        child: Column(
          children: [
            topWidget(),
            cardDetailSection(padding,context),
          ],
        ),
      ),
    );
  }

  Widget cardDetailSection(double padding, BuildContext context) {
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
            const CardDetail(isPrinciple: true),
            const DividerWidget(),
            const MarginWidget(),
            const CardDetail(),
            const DividerWidget(),
            const MarginWidget(factor: 2),
            InkWell(
              onTap: (){
                Functions.push(context, const AddBalance());
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.add),
                  const MarginWidget(isHorizontal: true),
                  Text(
                    "Adicionar Cartão",
                    style: AppTextStyles.captionMedium(color: CColors.primary),
                  )
                ],
              ),
            )
          ],
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
