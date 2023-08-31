import 'package:flutter/material.dart';
import 'package:projeto/extras/app_textstyles.dart';
import 'package:projeto/extras/extensions.dart';
import 'package:projeto/screens/dashboard/profile/widgets/prodileAppBar.dart';
import 'package:projeto/widgets/margin_widget.dart';

class SelectPaymentType extends StatefulWidget {
  const SelectPaymentType({Key? key}) : super(key: key);

  @override
  State<SelectPaymentType> createState() => _SelectPaymentTypeState();
}

class _SelectPaymentTypeState extends State<SelectPaymentType> {


  late double width,padding;
  @override
  Widget build(BuildContext context) {
    width = context.width;
    padding = width * 0.04;
    return Scaffold(
      appBar: profileAppBar("Inserir Crédito"),
      body: Padding(
        padding:  EdgeInsets.only(left: padding, right: padding),
        child: Column(
          children: [
            const MarginWidget(),
            Text("Selecione a forma de pagamento",style: AppTextStyles.titleMedium(),)
          ],
        ),
      ),
    );
  }
}
