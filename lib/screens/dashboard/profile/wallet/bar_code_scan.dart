import 'package:flutter/material.dart';
import 'package:projeto/extras/app_assets.dart';
import 'package:projeto/extras/app_textstyles.dart';
import 'package:utility_extensions/utility_extensions.dart';
import 'package:projeto/widgets/c_profile_app_bar.dart';
import 'package:projeto/widgets/custom_asset_image.dart';
import 'package:projeto/widgets/margin_widget.dart';
import 'package:projeto/widgets/textfield_widget.dart';

class BarCodeScan extends StatefulWidget {
  const BarCodeScan({Key? key}) : super(key: key);

  @override
  State<BarCodeScan> createState() => _BarCodeScanState();
}

class _BarCodeScanState extends State<BarCodeScan> {
  late double width, padding;

  TextEditingController barCodeC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    width = context.width;
    padding = width * 0.04;

    return Scaffold(
      appBar: CustomAppBar("Inserir Crédito"),
      body: Padding(
        padding: EdgeInsets.only(left: padding, right: padding),
        child: Center(
          child: Column(
            children: [
              const MarginWidget(),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Pix",
                  style: AppTextStyles.titleMedium(),
                ),
              ),
              const MarginWidget(factor: 2),
              CustomAssetImage(
                path: AppIcons.qr,
                height: 200,
              ),
              const MarginWidget(),
              TextFieldWidget(
                controller: barCodeC,
                hint: '',
                label: 'PIX Copia e Cola',
                suffixIcon: Transform.scale(
                  scale: 0.5,
                  child: CustomAssetImage(
                    path: AppIcons.copy,
                    height: 10,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
