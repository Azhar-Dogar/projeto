import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projeto/extras/constants.dart';
import 'package:projeto/extras/functions.dart';
import 'package:projeto/model/user_model.dart';
import 'package:utility_extensions/utility_extensions.dart';
import 'package:projeto/extras/app_textstyles.dart';
import 'package:projeto/screens/auth/register_password.dart';
import 'package:projeto/widgets/button_widget.dart';
import 'package:projeto/widgets/custom_text.dart';

import '../../extras/colors.dart';
import '../../widgets/margin_widget.dart';
import '../../widgets/textfield_widget.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController rgController = TextEditingController();
  TextEditingController drivingLicenceNumber = TextEditingController();
  TextEditingController drivingLicenceCategory = TextEditingController();

  TextEditingController zipCode = TextEditingController();
  TextEditingController road = TextEditingController();
  TextEditingController neighborhood = TextEditingController();
  TextEditingController number = TextEditingController();
  TextEditingController complement = TextEditingController();

  //bank
  TextEditingController bank = TextEditingController();
  TextEditingController agency = TextEditingController();
  TextEditingController account = TextEditingController();

  File? licenseDocument;

  String userType = "student";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const MarginWidget(
                  factor: 1,
                ),
                CustomText(
                  text: "Cadastro",
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                ),
                const MarginWidget(
                  factor: 0.3,
                ),
                CustomText(
                  text: "Inclua seus dados abaixo",
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                ),
                const MarginWidget(
                  factor: 1,
                ),
                CustomText(
                  text: "Dados pessoais",
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                ),
                const MarginWidget(
                  factor: 1,
                ),
                TextFieldWidget(
                    borderColor: CColors.textFieldBorder,
                    backColor: Colors.transparent,
                    label: "Nome Completo",
                    controller: name,
                    hint: ''),
                const MarginWidget(
                  factor: 1,
                ),
                TextFieldWidget(
                    borderColor: CColors.textFieldBorder,
                    backColor: Colors.transparent,
                    label: "E-mail",
                    controller: email,
                    hint: ''),
                const MarginWidget(
                  factor: 1,
                ),
                TextFieldWidget(
                    borderColor: CColors.textFieldBorder,
                    backColor: Colors.transparent,
                    label: "Número de Contato",
                    controller: phone,
                    hint: ''),
                const MarginWidget(
                  factor: 1,
                ),
                TextFieldWidget(
                    borderColor: CColors.textFieldBorder,
                    backColor: Colors.transparent,
                    label: "RG / CPF",
                    controller: rgController,
                    hint: ''),
                const MarginWidget(
                  factor: 1,
                ),
                TextFieldWidget(
                    borderColor: CColors.textFieldBorder,
                    backColor: Colors.transparent,
                    label: "Nº CNH",
                    controller: drivingLicenceNumber,
                    hint: ''),
                const MarginWidget(
                  factor: 1,
                ),
                TextFieldWidget(
                    borderColor: CColors.textFieldBorder,
                    backColor: Colors.transparent,
                    label: "Categoria da CNH",
                    controller: drivingLicenceCategory,
                    hint: ''),
                const MarginWidget(),
                uploadDocument(),
                const MarginWidget(
                  factor: 0.5,
                ),
                if (licenseDocument != null)
                  Text(
                    "Você receberá uma notificação no aplicativo com informações sobre a aprovação.",
                    style: AppTextStyles.captionRegular(),
                  ),
                const MarginWidget(
                  factor: 1.5,
                ),
                addressForm(),
                const MarginWidget(
                  factor: 1.5,
                ),
                if (userType == "student" || carType == "own") bankData(),
                const MarginWidget(
                  factor: 1.5,
                ),
                userTypeWidget(),
                const MarginWidget(
                  factor: 1.5,
                ),
                if (userType == "instructor") ...[
                  vehicleWidget(),
                  carTypeWidget(),
                  const MarginWidget(
                    factor: 1.5,
                  ),
                  if (carType == "own") ...[
                    dualCommandVehicle(),
                    const MarginWidget(
                      factor: 1.5,
                    ),
                  ],
                  documentsWidget(),
                  const MarginWidget(
                    factor: 1.5,
                  ),
                  expectedBudgetWidget(),
                  const MarginWidget(
                    factor: 1.5,
                  ),
                  if (carType == "rented") ...[
                    bankData(),
                    const MarginWidget(
                      factor: 1.5,
                    ),
                  ],
                ],
                ButtonWidget(
                  name: "Cadastrar",
                  onPressed: () {
                    if (userType == "instructor") {
                    } else {
                      if (validateFields([
                        name,
                        email,
                        phone,
                        rgController,
                        drivingLicenceNumber,
                        drivingLicenceCategory,
                        zipCode,
                        road,
                        neighborhood,
                        number,
                        complement,
                        bank,
                        agency,
                        account,
                      ])) {
                        if (licenseDocument == null) {
                          Functions.showSnackBar(
                              context, "Selecione o documento CNH");
                        } else {}
                      } else {
                        Functions.showSnackBar(context,
                            "Por favor, preencha todos os campos obrigatórios");
                      }
                    }
                    // context.push(
                    //   child: RegisterPassword(
                    //     isInstructor: userType == "instructor",
                    //   ),
                    // );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget userTypeWidget() {
    return Row(
      children: [
        Expanded(
          child: RadioListTile(
              contentPadding: EdgeInsets.zero,
              visualDensity: const VisualDensity(horizontal: -4),
              title: const Text("Sou aluno"),
              value: "student",
              groupValue: userType,
              onChanged: (v) {
                setState(() {
                  userType = v.toString();
                });
              }),
        ),
        Expanded(
          child: RadioListTile(
              contentPadding: EdgeInsets.zero,
              visualDensity: const VisualDensity(horizontal: -4),
              title: Text(
                "Sou instrutor",
                style: AppTextStyles.poppins(
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w400)),
              ),
              value: "instructor",
              groupValue: userType,
              onChanged: (v) {
                setState(() {
                  userType = v ?? "student";
                });
              }),
        ),
      ],
    );
  }

  Widget uploadDocument() {
    return documentWidget(
      image: licenseDocument == null
          ? Icons.file_upload_outlined
          : Icons.access_time_outlined,
      text: licenseDocument != null
          ? "Documento enviado para aprovação"
          : "Carregar documento da CNH",
      onTap: (file) {
        setState(() {
          licenseDocument = file;
        });
      },
    );
  }

  Widget documentWidget({
    required IconData image,
    required String text,
    required Function(File) onTap,
  }) {
    return InkWell(
      onTap: () async {
        FilePickerResult? result = await FilePicker.platform.pickFiles();

        if (result != null) {
          File file = File(result.files.single.path!);
          onTap(file);
        } else {
          // User canceled the picker
        }
      },
      child: Row(
        children: [
          Icon(image),
          const MarginWidget(
            isHorizontal: true,
          ),
          CustomText(
            text: text,
            fontSize: 12,
            fontWeight: FontWeight.w500,
            textColor: CColors.primary,
          )
        ],
      ),
    );
  }

  Widget addressForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: "Endereço",
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        const MarginWidget(),
        TextFieldWidget(
            borderColor: CColors.textFieldBorder,
            backColor: Colors.transparent,
            label: "CEP",
            controller: zipCode,
            hint: ''),
        const MarginWidget(
          factor: 1,
        ),
        TextFieldWidget(
            borderColor: CColors.textFieldBorder,
            backColor: Colors.transparent,
            label: "Rua",
            controller: road,
            hint: ''),
        const MarginWidget(
          factor: 1,
        ),
        TextFieldWidget(
            borderColor: CColors.textFieldBorder,
            backColor: Colors.transparent,
            label: "Bairro",
            controller: neighborhood,
            hint: ''),
        const MarginWidget(
          factor: 1,
        ),
        Row(
          children: [
            Expanded(
              child: TextFieldWidget(
                  borderColor: CColors.textFieldBorder,
                  backColor: Colors.transparent,
                  label: "Nº",
                  controller: number,
                  hint: ''),
            ),
            const MarginWidget(
              isHorizontal: true,
            ),
            Expanded(
              child: TextFieldWidget(
                borderColor: CColors.textFieldBorder,
                backColor: Colors.transparent,
                label: "Complemento",
                controller: complement,
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget bankData() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: "Dados Bancários",
          fontWeight: FontWeight.w500,
          fontSize: 16,
        ),
        const MarginWidget(),
        TextFieldWidget(
            borderColor: CColors.textFieldBorder,
            backColor: Colors.transparent,
            label: "Banco",
            controller: drivingLicenceNumber,
            hint: ''),
        const MarginWidget(),
        TextFieldWidget(
            borderColor: CColors.textFieldBorder,
            backColor: Colors.transparent,
            label: "Agência",
            controller: drivingLicenceNumber,
            hint: ''),
        const MarginWidget(),
        TextFieldWidget(
          borderColor: CColors.textFieldBorder,
          backColor: Colors.transparent,
          label: "Conta",
          controller: drivingLicenceNumber,
          
        ),
      ],
    );
  }

  Widget vehicleWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: "Seu Veículo",
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        const MarginWidget(),
        TextFieldWidget(
            borderColor: CColors.textFieldBorder,
            backColor: Colors.transparent,
            label: "Marca",
            controller: drivingLicenceNumber,
            hint: ''),
        const MarginWidget(
          factor: 1,
        ),
        TextFieldWidget(
            borderColor: CColors.textFieldBorder,
            backColor: Colors.transparent,
            label: "Ano",
            controller: drivingLicenceNumber,
            hint: ''),
        const MarginWidget(
          factor: 1,
        ),
        TextFieldWidget(
          borderColor: CColors.textFieldBorder,
          backColor: Colors.transparent,
          label: "Veículo",
          controller: drivingLicenceNumber,
          
        ),
        const MarginWidget(
          factor: 1,
        ),
      ],
    );
  }

  String carType = "own";

  carTypeWidget() {
    return Row(
      children: [
        Expanded(
          child: RadioListTile(
              contentPadding: EdgeInsets.zero,
              visualDensity: const VisualDensity(horizontal: -4),
              title: const Text("Carro próprio"),
              value: "own",
              groupValue: carType,
              onChanged: (v) {
                setState(() {
                  carType = v.toString();
                });
              }),
        ),
        Expanded(
          child: RadioListTile(
              contentPadding: EdgeInsets.zero,
              visualDensity: const VisualDensity(horizontal: -4),
              title: Text(
                "Carro alugado",
                style: AppTextStyles.poppins(
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w400)),
              ),
              value: "rented",
              groupValue: carType,
              onChanged: (v) {
                setState(() {
                  carType = v ?? "student";
                });
              }),
        ),
      ],
    );
  }

  var isDualCommand = false;

  Widget dualCommandVehicle() {
    return Row(
      children: [
        CupertinoSwitch(
          value: isDualCommand,
          onChanged: (value) {
            setState(() {
              isDualCommand = value;
            });
          },
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Text(
            "Veículo com duplo comando",
            style: AppTextStyles.captionMedium(),
          ),
        ),
      ],
    );
  }

  Widget documentsWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: "Enviar documentos do veículo",
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        const MarginWidget(),
        documentWidget(
          image: Icons.file_upload_outlined,
          text: "Foto do Veículo",
          onTap: (file) {},
        ),
        const MarginWidget(
          factor: 0.7,
        ),
        documentWidget(
          image: Icons.file_upload_outlined,
          text: "Documento do Veículo",
          onTap: (file) {},
        ),
        const MarginWidget(
          factor: 0.7,
        ),
        documentWidget(
          image: Icons.file_upload_outlined,
          text: "Licencimento do Veículo",
          onTap: (file) {},
        ),
        const MarginWidget(
          factor: 0.7,
        ),
        documentWidget(
          image: Icons.file_upload_outlined,
          text: "Seguro do Veículo",
          onTap: (file) {},
        ),
        const MarginWidget(
          factor: 0.7,
        ),
        if (carType != "own")
          documentWidget(
            image: Icons.file_upload_outlined,
            text: "Contrato de Locação",
            onTap: (file) {},
          ),
      ],
    );
  }

  Widget expectedBudgetWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: "Quanto gostaria de receber por hora/aula?",
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        const MarginWidget(
          factor: 0.7,
        ),
        TextFieldWidget(
          borderColor: CColors.textFieldBorder,
          backColor: Colors.transparent,
          label: "Valor",
          controller: name,
          
        ),
      ],
    );
  }

  Future<void> registerUser() async {
    var model = UserModel(
      name: name.text,
      email: email.text,
      phone: phone.text,
      rgCpf: rgController.text,
      licenceNumber: drivingLicenceNumber.text,
      licenseCategory: drivingLicenceCategory.text,
      zipCode: zipCode.text,
      road: road.text,
      neighbourhood: neighborhood.text,
      number: number.text,
      complement: complement.text,
      bank: bank.text,
      agency: agency.text,
      account: account.text,
    );

    model.licenseDocumentFile = licenseDocument;
    context.push(
        child: RegisterPassword(
      user: model,
    ));
  }
}
