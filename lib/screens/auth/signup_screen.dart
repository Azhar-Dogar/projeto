import 'dart:io';
import 'dart:math';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projeto/extras/constants.dart';
import 'package:projeto/extras/functions.dart';
import 'package:projeto/model/brand_model.dart';
import 'package:projeto/model/car_model.dart';
import 'package:projeto/model/user_model.dart';
import 'package:projeto/widgets/drop_down_widget.dart';
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
  TextEditingController credential = TextEditingController();

  TextEditingController zipCode = TextEditingController();
  TextEditingController road = TextEditingController();
  TextEditingController neighborhood = TextEditingController();
  TextEditingController number = TextEditingController();
  TextEditingController complement = TextEditingController();

  //bank
  TextEditingController bank = TextEditingController();
  TextEditingController agency = TextEditingController();
  TextEditingController account = TextEditingController();

  //vehicle

  TextEditingController brand = TextEditingController();
  TextEditingController year = TextEditingController();
  TextEditingController vehicle = TextEditingController();

  //rate
  TextEditingController amount = TextEditingController();

  File? licenseDocument;
  File? vehiclePhoto;
  File? credentialPhoto;
  File? vehicleDocument;
  File? vehicleLicense;
  File? vehicleInsurance;
  File? leaseAgreement;

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
                DropDownWidget(
                  dropdownItems: Constants.drivingLicenseCategoriesPortugal,
                  onSelect: (value) {
                    drivingLicenceCategory.text = value;
                  },
                  label: "Categoria da CNH",
                  borderColor: CColors.textFieldBorder,
                ),
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
                  if (userType == "instructor") ...[
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
                        brand,
                        year,
                        vehicle,
                        amount,
                        credential
                      ])) {
                        if (!email.text.isValidEmail) {
                          Functions.showSnackBar(context,
                              "Por favor insira um endereço de e-mail válido.");
                        } else if (licenseDocument == null ||
                            vehiclePhoto == null ||
                            vehicleDocument == null ||
                            vehicleLicense == null ||
                            vehicleInsurance == null ||
                            credentialPhoto == null) {
                          Functions.showSnackBar(
                              context, "Anexe todos os documentos necessários");
                        } else if ((carType == "rented" &&
                            leaseAgreement == null)) {
                          Functions.showSnackBar(
                              context, "Anexe todos os documentos necessários");
                        } else {
                          registerUser();
                        }
                      } else {
                        Functions.showSnackBar(context,
                            "Por favor, preencha todos os campos obrigatórios.");
                      }
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
                      ])) {
                        if (!email.text.isValidEmail) {
                          Functions.showSnackBar(context,
                              "Por favor insira um endereço de e-mail válido.");
                        } else if (licenseDocument == null) {
                          Functions.showSnackBar(
                              context, "Selecione o documento CNH.");
                        } else {
                          registerUser();
                        }
                      } else {
                        Functions.showSnackBar(context,
                            "Por favor, preencha todos os campos obrigatórios.");
                      }
                    }
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
        var file = await Functions.pickImage();
        if (file != null) {
          onTap(file);
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
        DropDownWidget(
          dropdownItems: Constants.banksInPortugal,
          onSelect: (value) {
            bank.text = value;
          },
          label: "Banco",
          borderColor: CColors.textFieldBorder,
        ),
        const MarginWidget(),
        TextFieldWidget(
            borderColor: CColors.textFieldBorder,
            backColor: Colors.transparent,
            label: "Agência",
            controller: agency,
            hint: ''),
        const MarginWidget(),
        TextFieldWidget(
          borderColor: CColors.textFieldBorder,
          backColor: Colors.transparent,
          label: "Conta",
          controller: account,
        ),
      ],
    );
  }

  Widget vehicleWidget() {
    for (var b in Constants.brands) {
      print(b.toString());
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: "Credential",
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        const MarginWidget(),
        TextFieldWidget(
            borderColor: CColors.textFieldBorder,
            backColor: Colors.transparent,
            label: "Nº Credential",
            controller: credential,
            hint: ''),
        const MarginWidget(factor: 2),
        documentWidget(
          image: credentialPhoto == null
              ? Icons.file_upload_outlined
              : Icons.access_time_outlined,
          text: credentialPhoto == null
              ? "Foto do Credential"
              : "Foto enviada para aprovação",
          onTap: (file) {
            setState(() {
              credentialPhoto = file;
            });
          },
        ),
        const MarginWidget(factor: 2),
        CustomText(
          text: "Seu Veículo",
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        const MarginWidget(),
        DropDownWidget(
          dropdownItems: List.generate(Constants.brands.length,
              (index) => Constants.brands[index].brand),
          onSelect: (value) {
            setState(() {
              brand.text = value;
              vehicle.text = "";
            });
          },
          label: "Marca",
        ),
        const MarginWidget(
          factor: 1,
        ),
        Builder(builder: (context) {
          var currentYear = DateTime.now().year;
          return DropDownWidget(
            dropdownItems:
                List.generate(40, (i) => (currentYear - i).toString()),
            onSelect: (value) {
              year.text = value;
            },
            label: "Ano",
          );
        }),
        const MarginWidget(
          factor: 1,
        ),
        Builder(builder: (context) {
          BrandModel? model = Constants.brands
              .where((element) => element.brand == brand.text)
              .firstOrNull;
          return DropDownWidget(
            key: Key("${Random().nextInt(10000)}"),
            dropdownItems: model?.vehicles ?? [],
            onSelect: (value) {
              vehicle.text = value;
            },
            label: "Veículo",
          );
        }),
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
                  if (carType == "own") {
                    leaseAgreement = null;
                  }
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
                  carType = v ?? "own";
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
          image: vehiclePhoto == null
              ? Icons.file_upload_outlined
              : Icons.access_time_outlined,
          text: vehiclePhoto == null
              ? "Foto do Veículo"
              : "Foto enviada para aprovação",
          onTap: (file) {
            setState(() {
              vehiclePhoto = file;
            });
          },
        ),
        const MarginWidget(
          factor: 0.7,
        ),
        documentWidget(
          image: vehicleDocument == null
              ? Icons.file_upload_outlined
              : Icons.access_time_outlined,
          text: vehicleDocument == null
              ? "Documento do Veículo"
              : "Documento enviado para aprovação",
          onTap: (file) {
            setState(() {
              vehicleDocument = file;
            });
          },
        ),
        const MarginWidget(
          factor: 0.7,
        ),
        documentWidget(
          image: vehicleLicense == null
              ? Icons.file_upload_outlined
              : Icons.access_time_outlined,
          text: vehicleLicense == null
              ? "Licencimento do Veículo"
              : "Licenciamento enviado para aprovação",
          onTap: (file) {
            setState(() {
              vehicleLicense = file;
            });
          },
        ),
        const MarginWidget(
          factor: 0.7,
        ),
        documentWidget(
          image: vehicleInsurance == null
              ? Icons.file_upload_outlined
              : Icons.access_time_outlined,
          text: vehicleInsurance == null
              ? "Seguro do Veículo"
              : "Seguro enviado para aprovação",
          onTap: (file) {
            setState(() {
              vehicleInsurance = file;
            });
          },
        ),
        const MarginWidget(
          factor: 0.7,
        ),
        if (carType != "own")
          documentWidget(
            image: leaseAgreement == null
                ? Icons.file_upload_outlined
                : Icons.access_time_outlined,
            text: leaseAgreement == null
                ? "Contrato de Locação"
                : "Contrato de locação submetido para aprovação",
            onTap: (file) {
              setState(() {
                leaseAgreement = file;
              });
            },
          ),
        if (vehiclePhoto != null ||
            vehicleDocument != null ||
            vehicleLicense != null ||
            vehicleInsurance != null ||
            leaseAgreement != null)
          Text(
            "Você receberá uma notificação no aplicativo com informações sobre a aprovação.",
            style: AppTextStyles.captionRegular(),
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
          controller: amount,
        ),
      ],
    );
  }

  Future<void> registerUser() async {
    bool isUser = userType == "student";
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
      isUser: isUser,
      bank: isUser ? null : bank.text,
      credential: isUser? null : credential.text,
      agency: isUser ? null : agency.text,
      account: isUser ? null : account.text,
      amount: isUser ? null : amount.text,
    );

    model.licenseDocumentFile = licenseDocument;
    model.credentialDocumentFile = credentialPhoto;

    CarModel? car;

    if (!isUser) {
      car = CarModel(
        brand: brand.text,
        year: year.text,
        vehicle: vehicle.text,
        carType: carType,
        isDualCommand: isDualCommand,
        isPrimary: true,
      );

      car.vehicleDocumentFile = vehicleDocument;
      car.vehiclePhotoFile = vehiclePhoto;
      car.vehicleLicenseFile = vehicleLicense;
      car.vehicleInsuranceFile = vehicleInsurance;
      car.leaseAgreementFile = leaseAgreement;
    }

    context.push(
      child: RegisterPassword(
        user: model,
        car: car,
      ),
    );
  }
}
