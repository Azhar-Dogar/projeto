import 'package:flutter/material.dart';
import 'package:projeto/extras/app_textstyles.dart';
import 'package:projeto/extras/colors.dart';
import 'package:projeto/extras/extensions.dart';
import 'package:projeto/screens/dashboard/profile/add_new_card.dart';
import 'package:projeto/screens/dashboard/profile/bar_code_scan.dart';
import 'package:projeto/screens/dashboard/profile/widgets/card_detail.dart';
import 'package:projeto/screens/dashboard/profile/widgets/prodileAppBar.dart';
import 'package:projeto/widgets/button_widget.dart';
import 'package:projeto/widgets/margin_widget.dart';

import '../../../extras/functions.dart';
import '../../../widgets/divider_widget.dart';
import 'add_balance.dart';

class SelectPaymentType extends StatefulWidget {
  const SelectPaymentType({Key? key}) : super(key: key);

  @override
  State<SelectPaymentType> createState() => _SelectPaymentTypeState();
}

class _SelectPaymentTypeState extends State<SelectPaymentType> {
  late double width, padding;

  @override
  Widget build(BuildContext context) {
    width = context.width;
    padding = width * 0.04;
    return Scaffold(
      appBar: profileAppBar("Inserir Crédito"),
      body: Padding(
        padding: EdgeInsets.only(left: padding, right: padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const MarginWidget(),
            Text(
              "Selecione a forma de pagamento",
              style: AppTextStyles.titleMedium(),
            ),
            const MarginWidget(factor: .5),
            radioOption(const CardDetail(isPrinciple: true, isEdit: true)),
            radioOption(const CardDetail(isPrinciple: true, isEdit: true)),
            InkWell(
              onTap: () {
                Functions.push(context, const BarCodeScan());
              },
              child: radioOption(Text(
                "PIX",
                style: AppTextStyles.subTitleMedium(),
              )),
            ),
            const MarginWidget(factor: 1.5),
            InkWell(
              onTap: () {
                Functions.push(context, const AddNewCard());
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
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
            const Expanded(child: SizedBox()),
            ButtonWidget(name: "Selecionar", onPressed: () {}),
            const MarginWidget(),
          ],
        ),
      ),
    );
  }

  Widget radioOption(Widget widget) {
    return Column(
      children: [
        const MarginWidget(factor: 1.5),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 18,
              width: 18,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: CColors.bluePrima,
                ),
              ),
            ),
            const MarginWidget(isHorizontal: true, factor: 1.5),
            Expanded(
              child: widget,
            ),
          ],
        ),
        if (widget is Text) ...[
          const MarginWidget(factor: 2),
        ] else ...[
          const MarginWidget(),
        ],
        const Padding(
          padding: EdgeInsets.only(left: 20),
          child: DividerWidget(),
        ),
      ],
    );
  }

  Widget type(Widget widget) {
    return SizedBox(
      width: 160,
      child: RadioMenuButton(
        value: false,
        groupValue: true,
        onChanged: (value) {},
        child: widget,
      ),
    );
  }
}
