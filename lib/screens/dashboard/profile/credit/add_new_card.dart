import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_form.dart';
import 'package:flutter_credit_card/credit_card_model.dart';
import 'package:projeto/extras/app_assets.dart';
import 'package:projeto/extras/app_textstyles.dart';
import 'package:projeto/extras/colors.dart';
import 'package:projeto/extras/constants.dart';
import 'package:projeto/model/card_model.dart';
import 'package:projeto/provider/data_provider.dart';
import 'package:provider/provider.dart';
import 'package:utility_extensions/utility_extensions.dart';
import 'package:projeto/extras/functions.dart';
import 'package:projeto/screens/dashboard/profile/credit/success_message.dart';
import 'package:projeto/widgets/c_profile_app_bar.dart';
import 'package:projeto/widgets/button_widget.dart';
import 'package:projeto/widgets/custom_asset_image.dart';
import 'package:projeto/widgets/margin_widget.dart';
import 'package:projeto/widgets/textfield_widget.dart';

import '../../../../model/user_model.dart';
import '../../../../widgets/credit_card_form_widget.dart';

class AddNewCard extends StatefulWidget {
  const AddNewCard({Key? key, this.isEdit = false}) : super(key: key);

  final bool isEdit;

  @override
  State<AddNewCard> createState() => _AddNewCardState();
}

class _AddNewCardState extends State<AddNewCard> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late double width, padding;

  CreditCardModel? model;

  // TextEditingController numberC = TextEditingController();
  // TextEditingController nameC = TextEditingController();
  // TextEditingController validityC = TextEditingController();
  // TextEditingController codeC = TextEditingController();

  bool isEnabled = false;

  @override
  Widget build(BuildContext context) {
    width = context.width;
    padding = width * 0.04;

    return Scaffold(
      appBar: CustomAppBar("Forma de Pagamento"),
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
                      "Adicionar Cartão",
                      style: AppTextStyles.titleMedium(),
                    ),
                    const MarginWidget(factor: 1.5),
                    cardSketch(),
                    const MarginWidget(),

                    CreditCardFormWidget(
                      formKey: formKey,
                      // Required
                      themeColor: Colors.red,
                      obscureCvv: false,
                      obscureNumber: true,
                      isHolderNameVisible: true,
                      isCardNumberVisible: true,
                      isExpiryDateVisible: true,
                      enableCvv: true,
                      cardNumberDecoration: buildInputDecoration(
                          'Número do Cartão', 'XXXX XXXX XXXX XXXX'),
                      expiryDateDecoration:
                          buildInputDecoration('Validade', 'XX/XX'),
                      cvvCodeDecoration: buildInputDecoration('CVV', 'XXX'),
                      cardHolderDecoration: buildInputDecoration(
                          'Nome do Titular', 'Nome do Titular'),
                      cardNumber: '',
                      expiryDate: '',
                      cardHolderName: '',
                      cvvCode: '',
                      onCreditCardModelChange: (model) {
                        setState(() {
                          this.model = model;
                        });
                      },
                    ),
                    Switch(
                      value: isEnabled,
                      onChanged: (value) {
                        setState(() {
                          isEnabled = value;
                        });
                      },
                    ),
                    // if (!widget.isEdit) ...[
                    //   TextFieldWidget(
                    //     controller: numberC,
                    //     hint: '',
                    //     label: 'Número do Cartão',
                    //   ),
                    //   const MarginWidget(),
                    //   TextFieldWidget(
                    //     controller: nameC,
                    //     hint: '',
                    //     label: 'Nome do Titular',
                    //   ),
                    //   const MarginWidget(),
                    //   Row(
                    //     children: [
                    //       Expanded(
                    //           child: TextFieldWidget(
                    //         controller: validityC,
                    //         hint: '',
                    //         label: 'Validade',
                    //       )),
                    //       const MarginWidget(isHorizontal: true),
                    //       Expanded(
                    //           child: TextFieldWidget(
                    //         controller: codeC,
                    //         hint: '',
                    //         label: 'CVV',
                    //       )),
                    //     ],
                    //   ),
                    //   const MarginWidget(),
                    // ],
                    // Row(
                    //   children: [
                    //     Switch(
                    //       value: isEnabled,
                    //       onChanged: (value) {
                    //         setState(() {
                    //           isEnabled = value;
                    //         });
                    //       },
                    //     ),
                    //     const MarginWidget(isHorizontal: true),
                    //     Text(
                    //       "Cartão Principal",
                    //       style: AppTextStyles.subTitleMedium(),
                    //     )
                    //   ],
                    // ),
                    // if (widget.isEdit) ...[
                    //   const MarginWidget(),
                    //   Align(
                    //     alignment: Alignment.center,
                    //     child: Text(
                    //       "Excluir Cartão",
                    //       style: AppTextStyles.captionMedium(color: CColors.primary),
                    //     ),
                    //   ),
                    // ],
                  ],
                ),
              ),
            ),
            ButtonWidget(
                name: widget.isEdit ? "Salvar" : "Adicionar Cartão",
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    try {
                      CardModel cardModel = CardModel(
                        number: model!.cardNumber,
                          holderName: model!.cardHolderName,
                          validity: model!.expiryDate,
                          cvv: model!.cvvCode,
                          mainCard: isEnabled);

                      UserModel userModel =
                          context.read<DataProvider>().userModel!;

                      if (isEnabled) {
                        userModel.cardsList
                            .any((element) => element.mainCard = false);
                      }
                      userModel.cardsList.add(cardModel);

                      Functions.showLoading(context);
                      await Constants.users.doc(Constants.uid()).update({
                        "cardsList": userModel.cardsList.map((e) => e.toMap()).toList(),
                      });
                      Navigator.of(context,rootNavigator: true).pop();
                      context.pop();
                    } on FirebaseException catch (e) {}
                  }
                  return;
                  // if (!widget.isEdit) {
                  //   if (numberC.text.isEmpty) {
                  //     Functions.showSnackBar(context,
                  //         "Por favor, insira o número do cartão primeiro");
                  //     return;
                  //   }
                  //   if (nameC.text.isEmpty) {
                  //     Functions.showSnackBar(context,
                  //         "Por favor, insira primeiro o nome do titular do cartão");
                  //     return;
                  //   }
                  //   if (validityC.text.isEmpty) {
                  //     Functions.showSnackBar(context,
                  //         "Por favor, insira a validade do cartão primeiro");
                  //     return;
                  //   }
                  //   if (codeC.text.isEmpty) {
                  //     Functions.showSnackBar(context, "Por favor insira o CVV");
                  //     return;
                  //   }
                  // }
                  // Functions.push(context, const SuccessMessage());
                }),
            const MarginWidget(),
          ],
        ),
      ),
    );
  }

  InputDecoration buildInputDecoration(String label, String hint) {
    return InputDecoration(
      border: borderStyle(),
      labelStyle: labelStyle(),
      focusedBorder: focusedBorder(),
      labelText: label,
      hintText: hint,
    );
  }

  OutlineInputBorder focusedBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: Colors.black.withOpacity(0.5), width: 1),
    );
  }

  OutlineInputBorder borderStyle() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
    );
  }

  TextStyle labelStyle() {
    return AppTextStyles.poppins(
        style: TextStyle(
      fontSize: 12,
      color: CColors.labelColor,
    ));
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
