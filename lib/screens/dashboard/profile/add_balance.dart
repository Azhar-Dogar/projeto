import 'package:flutter/material.dart';
import 'package:projeto/extras/app_textstyles.dart';
import 'package:projeto/extras/extensions.dart';
import 'package:projeto/extras/functions.dart';
import 'package:projeto/screens/dashboard/profile/select_payment_type.dart';
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

  TextEditingController controller = TextEditingController();

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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const MarginWidget(),
            Text(
              "Qual valor você deseja inserir?",
              style: AppTextStyles.titleMedium(),
            ),
            const MarginWidget(),
            amount("R\$ 50,00"),
            amount("R\$ 50,00"),
            amount("R\$ 50,00"),
            amount("R\$ 50,00"),
            amount("Outro valor"),
            TextFieldWidget(
              controller: controller,
              hint: 'R\$ 0,00',
            ),
            const Expanded(child: SizedBox()),
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
              Functions.push(context, const SelectPaymentType());
            }),
            const MarginWidget(),
          ],
        ),
      ),
    );
  }

  Widget amount(String str) {
    return SizedBox(
      width: 160,
      child: RadioMenuButton(
        value: false,
        groupValue: true,
        onChanged: (value) {},
        child: Text(
          str,
          style: AppTextStyles.subTitleMedium(),
        ),
      ),
    );
  }
}
