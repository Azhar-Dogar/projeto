import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projeto/extras/app_textstyles.dart';
import 'package:projeto/extras/colors.dart';
import 'package:projeto/extras/constants.dart';
import 'package:projeto/model/card_model.dart';
import 'package:projeto/provider/data_provider.dart';
import 'package:projeto/screens/dashboard/profile/wallet/success_message.dart';
import 'package:provider/provider.dart';
import 'package:utility_extensions/utility_extensions.dart';
import 'package:projeto/screens/dashboard/profile/widgets/card_detail.dart';
import 'package:projeto/widgets/c_profile_app_bar.dart';
import 'package:projeto/widgets/button_widget.dart';
import 'package:projeto/widgets/margin_widget.dart';
import '../../../../extras/functions.dart';
import '../../../../widgets/divider_widget.dart';
import 'add_new_card.dart';
import 'bar_code_scan.dart';

class SelectPaymentType extends StatefulWidget {
  const SelectPaymentType({Key? key, required this.amount}) : super(key: key);

  final double amount;

  @override
  State<SelectPaymentType> createState() => _SelectPaymentTypeState();
}

class _SelectPaymentTypeState extends State<SelectPaymentType> {
  late double width, padding;

  late DataProvider dataProvider;

  String? selected;

  @override
  void initState() {
    super.initState();
    dataProvider = context.read<DataProvider>();

    CardModel? cardModel = dataProvider.userModel!.cardsList.where((element) => element.mainCard).firstOrNull;

    if (cardModel != null) {
      selected = cardModel.number;
    }
  }

  @override
  Widget build(BuildContext context) {
    width = context.width;
    padding = width * 0.04;
    return Consumer<DataProvider>(builder: (ctx, value, child) {
      dataProvider = value;
      return Scaffold(
        appBar: CustomAppBar("Inserir Crédito"),
        body: Padding(
          padding: EdgeInsets.only(left: padding, right: padding),
          child: Column(
            children: [
              cardsSelection(context),
              ButtonWidget(
                  name: "Selecionar",
                  onPressed: () {
                    if (selected == null) {
                      Functions.showSnackBar(context, "Selecione a opção de pagamento primeiro");
                      return;
                    }else if (selected == "pix") {
                      context.push(child: BarCodeScan());
                    }else{
                      try {
                        Constants.users.doc(Constants.uid()).update({
                          "credits":
                          widget.amount + dataProvider.userModel!.credits!,
                        });
                      } on FirebaseException catch (e) {
                        print(e);
                      }

                      context.push(child: const SuccessMessage());
                    }
                  }),
              const MarginWidget(),
            ],
          ),
        ),
      );
    });
  }

  Widget cardsSelection(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const MarginWidget(),
            Text(
              "Selecione a forma de pagamento",
              style: AppTextStyles.titleMedium(),
            ),
            const MarginWidget(factor: .5),
            if (dataProvider.userModel!.cardsList.isEmpty) ...[
              const MarginWidget(),
              Center(
                  child: Text(
                "Nenhum cartão ainda",
                style: AppTextStyles.titleRegular(),
              )),
              const MarginWidget(),
            ] else ...[
              for (var card in dataProvider.userModel!.cardsList) ...[
                radioOption(
                    CardDetail(
                      isEdit: true,
                      cardModel: card,
                    ),
                    card.number),
              ],
            ],
            //   Functions.push(context, const BarCodeScan());
            radioOption(
                Text(
                  "PIX",
                  style: AppTextStyles.subTitleMedium(),
                ),
                "pix"),
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
            const MarginWidget(factor: 2),
          ],
        ),
      ),
    );
  }

  Widget radioOption(Widget widget, String value) {
    return InkWell(
      onTap: () {
        setState(() {
          selected = value;
        });
      },
      child: Column(
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
                padding: EdgeInsets.all(3),
                child: selected == value
                    ? CircleAvatar(
                        backgroundColor: Colors.black,
                      )
                    : null,
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
      ),
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
