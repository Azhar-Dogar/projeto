import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:projeto/extras/constants.dart';
import 'package:projeto/extras/functions.dart';
import 'package:projeto/model/car_model.dart';
import 'package:projeto/widgets/button_widget.dart';
import 'package:projeto/widgets/drop_down_widget.dart';
import 'package:projeto/widgets/textfield_widget.dart';
import 'package:utility_extensions/extensions/font_utilities.dart';
import 'package:utility_extensions/extensions/functions.dart';
import 'package:utility_extensions/utility_extensions.dart';

import '../../../extras/app_textstyles.dart';
import '../../../extras/colors.dart';
import '../../../widgets/custom_text.dart';
import '../../../widgets/margin_widget.dart';

class AddCar extends StatefulWidget {
  const AddCar({super.key, this.car});

  final CarModel? car;

  @override
  State<AddCar> createState() => _AddCarState();
}

class _AddCarState extends State<AddCar> {
  //vehicle

  TextEditingController brand = TextEditingController();
  TextEditingController year = TextEditingController();
  TextEditingController vehicle = TextEditingController();

  File? vehiclePhoto;
  File? vehicleDocument;
  File? vehicleLicense;
  File? vehicleInsurance;
  File? leaseAgreement;

  bool isEditing = false;

  @override
  void initState() {
    isEditing = widget.car == null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Meus Veículos"),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  DropDownWidget(
                    dropdownItems: Constants.portugueseVehicleBrands,
                    onSelect: (value) {
                      brand.text = value;
                    },
                    label: "Marca",
                    isEdit: isEditing,
                  ),
                  MarginWidget(),
                  Builder(builder: (context) {
                    var currentYear = DateTime.now().year;
                    return DropDownWidget(
                      dropdownItems: List.generate(
                          40, (i) => (currentYear - i).toString()),
                      onSelect: (value) {
                        year.text = value;
                      },
                      label: "Ano",
                      isEdit: isEditing,
                    );
                  }),
                  MarginWidget(),
                  DropDownWidget(
                    dropdownItems: Constants.portugueseVehicleBrands,
                    onSelect: (value) {
                      vehicle.text = value;
                    },
                    label: "Veículo",
                    isEdit: isEditing,
                  ),
                  MarginWidget(),
                  documentsWidget(),
                ],
              ),
            ),
            ButtonWidget(
              name: "Salvar Alterações",
              onPressed: () {
                if (validateFields([brand, year, vehicle])) {
                  if (vehiclePhoto == null ||
                      vehicleDocument == null ||
                      vehicleLicense == null ||
                      vehicleInsurance == null) {
                    Functions.showSnackBar(
                        context, "Anexe todos os documentos necessários");
                  } else {
                    addCar();
                  }
                } else {
                  Functions.showSnackBar(context,
                      "Por favor, preencha todos os campos obrigatórios.");
                }
              },
            ),
            MarginWidget(),
          ],
        ),
      ),
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
        // if (carType != "own")
        //   documentWidget(
        //     image: leaseAgreement == null
        //         ? Icons.file_upload_outlined
        //         : Icons.access_time_outlined,
        //     text: leaseAgreement == null
        //         ? "Contrato de Locação"
        //         : "Contrato de locação submetido para aprovação",
        //     onTap: (file) {
        //       setState(() {
        //         leaseAgreement = file;
        //       });
        //     },
        //   ),
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

  Widget documentWidget({
    required IconData image,
    required String text,
    required Function(File) onTap,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            if (!isEditing) ...[
              Icon(image),
              const MarginWidget(
                isHorizontal: true,
              ),
            ],
            CustomText(
              text: text,
              fontSize: 12,
              fontWeight: FontWeight.w500,
              textColor: CColors.primary,
            ),
          ],
        ),
        if (isEditing)
          InkWell(
            onTap: () async {
              var file = await Functions.pickImage();
              if (file != null) {
                onTap(file);
              }
            },
            child: Text(
              "Enviar documento",
              style: AppTextStyles.poppins(
                style: TextStyle(
                  color: CColors.textColor,
                  fontWeight: FontWeights.medium,
                  fontSize: 12,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ),
      ],
    );
  }

  Future<void> addCar() async {
    Functions.showLoading(context);
    var doc = Constants.cars.doc();
    var model = CarModel(
      brand: brand.text,
      year: year.text,
      vehicle: vehicle.text,
      carType: "own",
      isDualCommand: false,
      vehiclePhoto: await Functions.uploadImage(vehiclePhoto!,
          path: "vehiclePhoto/${doc.id}.${vehiclePhoto!.path.split(".").last}"),
      vehicleDocument: await Functions.uploadImage(vehicleDocument!,
          path:
              "vehicleDocument/${doc.id}.${vehicleDocument!.path.split(".").last}"),
      vehicleLicense: await Functions.uploadImage(vehicleLicense!,
          path:
              "vehicleLicense/${doc.id}.${vehicleLicense!.path.split(".").last}"),
      vehicleInsurance: await Functions.uploadImage(vehicleInsurance!,
          path:
              "vehicleInsurance/${doc.id}.${vehicleInsurance!.path.split(".").last}"),
      isPrimary: false,
    );
    model.id = doc.id;
    model.uid = Constants.uid();

    await doc.set(model.toMap());

    Navigator.of(context, rootNavigator: true).pop();
    context.pop();


  }
}
