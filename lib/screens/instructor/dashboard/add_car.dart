import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:projeto/extras/constants.dart';
import 'package:projeto/widgets/drop_down_widget.dart';
import 'package:projeto/widgets/textfield_widget.dart';

import '../../../extras/app_textstyles.dart';
import '../../../extras/colors.dart';
import '../../../widgets/custom_text.dart';
import '../../../widgets/margin_widget.dart';

class AddCar extends StatefulWidget {
  const AddCar({super.key});

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
            DropDownWidget(
              dropdownItems: Constants.portugueseVehicleBrands,
              onSelect: (value) {
                brand.text = value;
              },
              label: "Marca",
            ),
            MarginWidget(),
            TextFieldWidget(
              controller: year,
              label: "Ano",
            ),
            MarginWidget(),
            TextFieldWidget(
              controller: vehicle,
              label: "Veículo",
            ),
            MarginWidget(),
            documentsWidget(),
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
    return InkWell(
      onTap: () async {
        FilePickerResult? result = await FilePicker.platform.pickFiles();
        if (result != null) {
          File file = File(result.files.single.path!);
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
}
