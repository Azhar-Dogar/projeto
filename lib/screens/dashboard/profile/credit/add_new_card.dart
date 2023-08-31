import 'package:flutter/material.dart';
import 'package:projeto/extras/app_assets.dart';
import 'package:projeto/extras/app_textstyles.dart';
import 'package:projeto/extras/colors.dart';
import 'package:projeto/extras/extensions.dart';
import 'package:projeto/extras/functions.dart';
import 'package:projeto/screens/dashboard/profile/credit/success_message.dart';
import 'package:projeto/widgets/c_profile_app_bar.dart';
import 'package:projeto/widgets/button_widget.dart';
import 'package:projeto/widgets/custom_asset_image.dart';
import 'package:projeto/widgets/margin_widget.dart';
import 'package:projeto/widgets/textfield_widget.dart';

class AddNewCard extends StatefulWidget {
  const AddNewCard({Key? key, this.isEdit = false}) : super(key: key);

  final bool isEdit;

  @override
  State<AddNewCard> createState() => _AddNewCardState();
}

class _AddNewCardState extends State<AddNewCard> {
  late double width, padding;

  TextEditingController numberC = TextEditingController();
  TextEditingController nameC = TextEditingController();
  TextEditingController validityC = TextEditingController();
  TextEditingController codeC = TextEditingController();

  bool isEnabled = true;

  @override
  Widget build(BuildContext context) {
    width = context.width;
    padding = width * 0.04;

    return Scaffold(
      appBar: CustomAppBar("Forma de Pagamento"),
      body: Padding(
        padding: EdgeInsets.only(left: padding, right: padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const MarginWidget(),
            Text(
              "Adicionar Cartão",
              style: AppTextStyles.titleMedium(),
            ),
            const MarginWidget(factor: 1.5),
            cardSketch(),
            const MarginWidget(),
            if (!widget.isEdit) ...[
              TextFieldWidget(
                controller: numberC,
                hint: '',
                label: 'Número do Cartão',
              ),
              const MarginWidget(),
              TextFieldWidget(
                controller: nameC,
                hint: '',
                label: 'Nome do Titular',
              ),
              const MarginWidget(),
              Row(
                children: [
                  Expanded(
                      child: TextFieldWidget(
                    controller: validityC,
                    hint: '',
                    label: 'Validade',
                  )),
                  const MarginWidget(isHorizontal: true),
                  Expanded(
                      child: TextFieldWidget(
                    controller: codeC,
                    hint: '',
                    label: 'CVV',
                  )),
                ],
              ),
              const MarginWidget(),
            ],
            Row(
              children: [
                Switch(
                  value: isEnabled,
                  onChanged: (value) {
                    setState(() {
                      isEnabled = value;
                    });
                  },
                ),
                const MarginWidget(isHorizontal: true),
                Text(
                  "Cartão Principal",
                  style: AppTextStyles.subTitleMedium(),
                )
              ],
            ),
            if (widget.isEdit) ...[
              const MarginWidget(),
              Align(
                alignment: Alignment.center,
                child: Text(
                  "Excluir Cartão",
                  style: AppTextStyles.captionMedium(color: CColors.primary),
                ),
              ),
            ],
            const Expanded(child: SizedBox()),
            ButtonWidget(
                name: widget.isEdit ? "Salvar" : "Adicionar Cartão",
                onPressed: () {
                  Functions.push(context, const SuccessMessage());
                }),
            const MarginWidget(),
          ],
        ),
      ),
    );
  }

  Widget cardSketch() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.black, borderRadius: BorderRadius.circular(8)),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Nome",
                style: AppTextStyles.subTitleMedium(color: Colors.white),
              ),
              CustomAssetImage(
                path: AppIcons.visa,
                color: Colors.white,
                height: 23,
                width: 30,
              )
            ],
          ),
          const MarginWidget(factor: 2),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "**** **** **** 1234",
                style: AppTextStyles.captionRegular(color: Colors.white),
              ),
              Text(
                "CVV",
                style: AppTextStyles.captionRegular(color: Colors.white),
              ),
            ],
          ),
          const MarginWidget(),
          Text(
            "05/28",
            style: AppTextStyles.captionRegular(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
