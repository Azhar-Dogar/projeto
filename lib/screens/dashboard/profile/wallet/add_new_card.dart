import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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
import 'package:projeto/widgets/c_profile_app_bar.dart';
import 'package:projeto/widgets/button_widget.dart';
import 'package:projeto/widgets/custom_asset_image.dart';
import 'package:projeto/widgets/margin_widget.dart';
import '../../../../model/user_model.dart';
import '../../../../widgets/credit_card_form_widget.dart';

class AddNewCard extends StatefulWidget {
  const AddNewCard({Key? key, this.cardModel}) : super(key: key);

  final CardModel? cardModel;

  @override
  State<AddNewCard> createState() => _AddNewCardState();
}

class _AddNewCardState extends State<AddNewCard> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late double width, padding;

  CreditCardModel? model;

  bool isMainCard = false;

  late UserModel userModel;

  @override
  void initState() {
    super.initState();

    userModel = context.read<DataProvider>().userModel!;

    if (widget.cardModel != null) {
      isMainCard = widget.cardModel!.mainCard;
    } else {
      if (userModel.cardsList.isEmpty) {
        isMainCard = true;
      }
    }
  }

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
                      "${widget.cardModel == null ? "Adicionar" : "Editar"} Cartão",
                      style: AppTextStyles.titleMedium(),
                    ),
                    const MarginWidget(factor: 1.5),
                    cardSketch(),
                    const MarginWidget(),
                    if (widget.cardModel == null) ...[
                      CreditCardFormWidget(
                        formKey: formKey,
                        // Required
                        themeColor: Colors.red,
                        obscureCvv: false,
                        obscureNumber: false,
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
                    ],
                    Switch(
                      value: isMainCard,
                      onChanged: (value) {
                        if ((userModel.cardsList.length == 1 &&
                                widget.cardModel != null) ||
                            userModel.cardsList.length == 0) {
                          // Functions.showSnackBar(context,
                          //     "Existe apenas um cartão no momento. Não é possível mudar isso");
                        } else {
                          setState(() {
                            isMainCard = value;
                          });
                        }
                      },
                    ),
                    if (widget.cardModel != null) ...[
                      const MarginWidget(),
                      Center(
                        child: InkWell(
                          onTap: () async {
                            UserModel model =
                                context.read<DataProvider>().userModel!;
                            model.cardsList.removeWhere((element) =>
                                element.number == widget.cardModel!.number);
                            try {
                              Functions.showLoading(context);
                              if (model.cardsList.length == 1) {
                                model.cardsList.first.mainCard = true;
                              }
                              await Constants.users.doc(model.uid).update({
                                "cardsList": model.cardsList
                                    .map((e) => e.toMap())
                                    .toList()
                              });

                              context.pop(rootNavigator: true);
                              context.pop();
                            } on FirebaseException catch (e) {
                              print(e);
                            }
                          },
                          child: Text(
                            "Excluir Cartão",
                            style: AppTextStyles.captionMedium(
                              color: CColors.primary,
                            ),
                          ),
                        ),
                      )
                    ],
                  ],
                ),
              ),
            ),
            ButtonWidget(
                name: widget.cardModel != null ? "Salvar" : "Adicionar Cartão",
                onPressed: () async {
                  print("object");
                  bool isValidate;

                  if (widget.cardModel != null) {
                    isValidate = true;
                  } else {
                    isValidate = formKey.currentState!.validate();
                    if (!isValidate) {
                      return;
                    }
                  }

                  try {
                    CardModel cardModel;
                    Functions.showLoading(context);
                    if (model == null && widget.cardModel != null) {
                      cardModel = CardModel(
                          number: widget.cardModel!.number,
                          holderName: widget.cardModel!.holderName,
                          validity: widget.cardModel!.validity,
                          cvv: widget.cardModel!.cvv,
                          mainCard: isMainCard);
                    } else {
                      cardModel = CardModel(
                          number: model!.cardNumber,
                          holderName: model!.cardHolderName,
                          validity: model!.expiryDate,
                          cvv: model!.cvvCode,
                          mainCard: isMainCard);
                    }

                    if (isMainCard) {
                      userModel.cardsList
                          .any((element) => element.mainCard = false);
                    }

                    if (widget.cardModel == null) {
                      userModel.cardsList.add(cardModel);
                    } else {
                      int index =
                          userModel.cardsList.indexOf(widget.cardModel!);
                      userModel.cardsList[index] = cardModel;

                      if (isMainCard == false &&
                          userModel.cardsList.length == 2) {
                        userModel.cardsList = userModel.cardsList.map((card) {
                          if (card.number != cardModel.number) {
                            card.mainCard = true;
                          }
                          return card;
                        }).toList();
                      }
                    }

                    await Constants.users.doc(Constants.uid()).update({
                      "cardsList":
                          userModel.cardsList.map((e) => e.toMap()).toList(),
                    });

                    Navigator.of(context, rootNavigator: true).pop();
                    context.pop();
                  } on FirebaseException catch (e) {
                    print(e);
                  }
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
