import 'package:flutter/material.dart';
import 'package:projeto/extras/app_assets.dart';
import 'package:projeto/extras/app_textstyles.dart';
import 'package:projeto/extras/colors.dart';
import 'package:projeto/extras/extensions.dart';
import 'package:projeto/widgets/custom_asset_image.dart';
import 'package:projeto/widgets/margin_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late double width, height, padding;

  @override
  Widget build(BuildContext context) {
    width = context.width;
    height = context.height;

    padding = width * 0.04;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          headerTrailing(),
        ],
      ),
      body: Column(
        children: [
          header(),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: padding, right: padding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  listTile("Meus dados", AppIcons.profile),
                  listTile("Meu Progresso", AppIcons.trending),
                  listTile("Carteira", AppIcons.brief),
                  Expanded(child: listTile("Inserir Crédito", AppIcons.dollar)),
                  bottomOption("Termos e Condições"),
                  const MarginWidget(),
                  bottomOption("Sair do App"),
                  const MarginWidget(factor: 2),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget header() {
    return Container(
      color: CColors.dashboard,
      child: Padding(
        padding: EdgeInsets.only(
            left: padding,
            right: padding,
            top: height * 0.04,
            bottom: height * 0.05),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              height: 90,
              width: 90,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                      color: Colors.black.withOpacity(0.5), width: 4)),
              child: ClipOval(
                child: CustomAssetImage(
                  fit: BoxFit.cover,
                  path: AppImages.demo,
                ),
              ),
            ),
            const MarginWidget(isHorizontal: true, factor: 1.4),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Claudia Silva",
                  style: AppTextStyles.titleMedium(),
                ),
                const MarginWidget(factor: 0.7),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: CColors.primary, width: 2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.only(
                      left: 32, right: 32, top: 8, bottom: 8),
                  child: Row(
                    children: [
                      const Icon(Icons.upload),
                      const MarginWidget(isHorizontal: true, factor: 0.5),
                      Text(
                        "Alterar foto",
                        style: AppTextStyles.captionMedium(
                          color: CColors.primary,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget bottomOption(String str) {
    return Padding(
      padding: padding2(),
      child: Text(
        str,
        style: AppTextStyles.captionMedium(color: CColors.primary),
      ),
    );
  }

  Widget listTile(String header, String icon) {
    return Column(
      children: [
        const MarginWidget(),
        Padding(
          padding: padding2(),
          child: Row(
            children: [
              CustomAssetImage(height: 24, path: icon),
              const MarginWidget(isHorizontal: true),
              Text(
                header,
                style: AppTextStyles.captionMedium(),
              )
            ],
          ),
        ),
        const MarginWidget(factor: 0.8),
        Divider(
          color: CColors.divider,
          height: 1,
        ),
      ],
    );
  }

  EdgeInsets padding2() => const EdgeInsets.only(left: 4, right: 4);

  Widget headerTrailing() {
    return Padding(
      padding: EdgeInsets.only(right: width * 0.04),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            "Crédito",
            style: AppTextStyles.captionMedium(),
          ),
          Text(
            "R\$ 800,00",
            style: AppTextStyles.subTitleMedium(color: CColors.primary),
          ),
        ],
      ),
    );
  }
}
