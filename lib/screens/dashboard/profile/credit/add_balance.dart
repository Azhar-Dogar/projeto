import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:projeto/extras/app_textstyles.dart';
import 'package:utility_extensions/utility_extensions.dart';
import 'package:projeto/extras/functions.dart';
import 'package:projeto/screens/dashboard/profile/credit/select_payment_type.dart';
import 'package:projeto/widgets/c_profile_app_bar.dart';
import 'package:projeto/widgets/button_widget.dart';
import 'package:projeto/widgets/margin_widget.dart';
import 'package:projeto/widgets/textfield_widget.dart';

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
            Expanded(
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
                    amount("R\$ 50,00",5000),
                    amount("R\$ 100,00",10000),
                    amount("R\$ 150,00",15000),
                    amount("R\$ 200,00",20000),
                    amount("R\$ 300,00",30000),
                    amount("Outro valor",0),
                    if(selected == 0)
                    TextFieldWidget(
                      textInputType: TextInputType.number,
                      controller: otherC,
                      hint: 'R\$ 0,00',
                    ),
                  ],
                ),

              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    "Forma de Pagamento",
                    style: AppTextStyles.captionRegular(),
                  ),
                ),
                Text(
                  "**** 1234 (Crédito)",
                  style: AppTextStyles.captionRegular(),
                ),
                const MarginWidget(isHorizontal: true, factor: 0.5),
                const Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 20,
                ),
              ],
            ),
            const MarginWidget(),
            ButtonWidget(name: "Inserir Crédito", onPressed: () {

              double amount = 0;
              if (selected == 0) {
                amount = double.parse(otherC.text.trim());
              }  else{
                amount = selected.toDouble();
              }
              Functions.push(context,  SelectPaymentType(amount: amount,));
            }),
            const MarginWidget(),
          ],
        ),
      ),
    );
  }

  Widget amount(String str,int value) {

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
