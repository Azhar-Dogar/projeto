
import 'package:flutter/material.dart';
import 'package:projeto/extras/app_textstyles.dart';
import 'package:projeto/extras/colors.dart';
import 'package:projeto/provider/data_provider.dart';
import 'package:provider/provider.dart';
import 'package:utility_extensions/utility_extensions.dart';
import 'package:projeto/extras/functions.dart';
import 'package:projeto/screens/dashboard/profile/widgets/card_detail.dart';
import 'package:projeto/widgets/c_profile_app_bar.dart';
import 'package:projeto/widgets/divider_widget.dart';
import 'package:projeto/widgets/margin_widget.dart';

import 'add_balance.dart';
import 'add_new_card.dart';

class Balance extends StatefulWidget {
  const Balance({Key? key}) : super(key: key);

  @override
  State<Balance> createState() => _BalanceState();
}

class _BalanceState extends State<Balance> {

  late DataProvider dataProvider;
  @override
  Widget build(BuildContext context) {
    double padding = context.width * 0.04;
    return Consumer<DataProvider>(
      builder: (context, value, child) {
        dataProvider = value;
        return Scaffold(
          appBar: CustomAppBar("Pagamento"),
          body: Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.black,
            child: Column(
              children: [
                topWidget(context),
                cardDetailSection(padding,context),
              ],
            ),
          ),
        );
      }
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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const MarginWidget(factor: 2),
              Text(
                "Cartões adicionados",
                style: AppTextStyles.subTitleMedium(),
              ),
              const MarginWidget(factor: 2),

              for(var card in dataProvider.userModel!.cardsList)...[
                 CardDetail(cardModel: card,isEdit: true,),
                const DividerWidget(),
                const MarginWidget(),
              ],
              const MarginWidget(),
              InkWell(
                onTap: (){
                  Functions.push(context, const AddNewCard());
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
              ),
              const MarginWidget(factor: 2),
            ],
          ),
        ),
      ),
    );
  }

  Widget topWidget(BuildContext context) {
    return Column(
      children: [
        const MarginWidget(factor: 2.5),
        Text(
          "R\$ ${dataProvider.userModel!.credits}",
          style: AppTextStyles.h4Medium(color: Colors.white),
        ),
        const MarginWidget(),
        Text(
          "Crédito",
          style: AppTextStyles.titleMedium(
              color: Colors.white, weight: FontWeight.w400),
        ),
        const MarginWidget(),
        addCredit(context),
        const MarginWidget(factor: 2.5),
      ],
    );
  }

  Widget addCredit(BuildContext context) {
    return InkWell(
      onTap: (){
        Functions.push(context, const AddBalance());
      },
      child: Container(
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
      ),
    );
  }
}
