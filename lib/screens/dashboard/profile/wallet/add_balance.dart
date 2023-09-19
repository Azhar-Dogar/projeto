import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projeto/extras/app_textstyles.dart';
import 'package:projeto/model/card_model.dart';
import 'package:projeto/provider/data_provider.dart';
import 'package:projeto/screens/dashboard/profile/wallet/select_payment_type.dart';
import 'package:projeto/screens/dashboard/profile/wallet/success_message.dart';
import 'package:provider/provider.dart';
import 'package:utility_extensions/utility_extensions.dart';
import 'package:projeto/extras/functions.dart';
import 'package:projeto/widgets/c_profile_app_bar.dart';
import 'package:projeto/widgets/button_widget.dart';
import 'package:projeto/widgets/margin_widget.dart';
import 'package:projeto/widgets/textfield_widget.dart';

import '../../../../extras/constants.dart';

class AddBalance extends StatefulWidget {
  const AddBalance({Key? key}) : super(key: key);

  @override
  State<AddBalance> createState() => _AddBalanceState();
}

class _AddBalanceState extends State<AddBalance> {
  late double width, height, padding;

  TextEditingController otherC = TextEditingController();

  bool other = false;

  int selected = 5000;

  late DataProvider dataProvider;

  @override
  void initState() {
    super.initState();
    dataProvider = context.read<DataProvider>();
  }

  @override
  Widget build(BuildContext context) {
    width = context.width;
    height = context.height;
    padding = width * 0.04;

    return Scaffold(
      appBar: CustomAppBar("Inserir Crédito"),
      body: Padding(
        padding: EdgeInsets.only(left: padding, right: padding),
        child: Column(
          children: [
            amountSelection(),
            if (dataProvider.userModel!.cardsList.isNotEmpty) ...[
              choosenCard(),
            ],
            const MarginWidget(),
            ButtonWidget(
                name: "Inserir Crédito",
                onPressed: () {
                  double amount = 0;
                  if (selected == 0) {
                    amount = double.parse(otherC.text.trim());
                  } else {
                    amount = selected.toDouble();
                  }

                  CardModel? model = dataProvider.userModel!.cardsList
                      .where((element) => element.mainCard)
                      .firstOrNull;

                  if (model != null) {
                    try {
                      Constants.users.doc(Constants.uid()).update({
                        "credits": amount + dataProvider.userModel!.credits!,
                      });
                    } on FirebaseException catch (e) {
                      print(e);
                    }

                    otherC.text = "";

                    context.push(child: const SuccessMessage());
                  } else {
                    Functions.push(
                        context,
                        SelectPaymentType(
                          amount: amount,
                        ));
                  }
                }),
            const MarginWidget(),
          ],
        ),
      ),
    );
  }

  Widget choosenCard() {
    CardModel? cardModel = dataProvider.userModel!.cardsList
        .where((element) => element.mainCard)
        .firstOrNull;

    double amount = 0;
    if (selected == 0) {
      if (otherC.text.isNotEmpty) {
        amount = double.parse(otherC.text.trim());
      }
    } else {
      amount = selected.toDouble();
    }

    return InkWell(
      onTap: () {
        if (amount != 0) {
          Functions.push(
              context,
              SelectPaymentType(
                amount: amount,
              ));
        }
      },
      child: Row(
        children: [
          Expanded(
            child: Text(
              "Forma de Pagamento",
              style: AppTextStyles.captionRegular(),
            ),
          ),
          Text(
            "**** ${cardModel!.number.substring(cardModel.number.length - 4)} (Crédito)",
            style: AppTextStyles.captionRegular(),
          ),
          const MarginWidget(isHorizontal: true, factor: 0.5),
          const Icon(
            Icons.arrow_forward_ios_rounded,
            size: 20,
          ),
        ],
      ),
    );
  }

  Widget amountSelection() {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const MarginWidget(),
            Text(
              "Qual valor você deseja inserir?",
              style: AppTextStyles.titleMedium(),
            ),
            const MarginWidget(),
            amount("R\$ 50,00", 50),
            amount("R\$ 100,00", 100),
            amount("R\$ 150,00", 150),
            amount("R\$ 200,00", 200),
            amount("R\$ 300,00", 300),
            amount("Outro valor", 0),
            if (selected == 0)
              TextFieldWidget(
                textInputType: TextInputType.number,
                controller: otherC,
                hint: 'R\$ 0,00',
              ),
          ],
        ),
      ),
    );
  }

  Widget amount(String str, int value) {
    return RadioMenuButton(
      value: value,
      groupValue: selected,
      onChanged: (value) {
        setState(() {
          selected = value!;
        });
      },
      child: Text(
        str,
        style: AppTextStyles.subTitleMedium(),
      ),
    );
  }
}
