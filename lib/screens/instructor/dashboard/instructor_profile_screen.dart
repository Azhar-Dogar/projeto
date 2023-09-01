import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:projeto/extras/app_assets.dart';
import 'package:projeto/extras/app_textstyles.dart';
import 'package:projeto/extras/colors.dart';
import 'package:projeto/extras/extensions.dart';
import 'package:projeto/extras/functions.dart';
import 'package:projeto/screens/dashboard/profile/credit/balance.dart';
import 'package:projeto/screens/dashboard/profile/meu_progresso.dart';
import 'package:projeto/screens/dashboard/profile/terms_condition.dart';
import 'package:projeto/screens/dashboard/profile/widgets/profile_header_widget.dart';
import 'package:projeto/widgets/button_widget.dart';
import 'package:projeto/widgets/custom_asset_image.dart';
import 'package:projeto/widgets/margin_widget.dart';

import '../../../widgets/textfield_widget.dart';

class InstructorProfileScreen extends StatefulWidget {
  const InstructorProfileScreen({super.key});

  @override
  State<InstructorProfileScreen> createState() => _InstructorProfileScreenState();
}

class _InstructorProfileScreenState extends State<InstructorProfileScreen> {
  late double width, height, padding;

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController rgController = TextEditingController();
  TextEditingController cnhController = TextEditingController();
  String? groupValue;

  TextEditingController cEPController = TextEditingController();
  TextEditingController ruaController = TextEditingController();
  TextEditingController bairroController = TextEditingController();
  TextEditingController nDegController = TextEditingController();

  bool isDetails = false, isEdit = false;

  @override
  Widget build(BuildContext context) {
    width = context.width;
    height = context.height;
    padding = width * 0.04;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const MarginWidget(factor: 3),
          const MarginWidget(factor: 0.8),
          header(),
          isDetails ? details() : profileMain(),
        ],
      ),
    );
  }

  Widget profileMain() {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.only(left: padding, right: padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            listTile("Meus dados", AppIcons.profile, onTap: () {
              setState(() {
                isDetails = true;
              });
            }),
            InkWell(
              onTap: () {
                context.push(child: const MeuProgresso());
              },
              child: listTile("Meus Veículos", AppIcons.carIcon),
            ),
            listTile("Minhas Avaliações", AppIcons.star),
            const Expanded(child: SizedBox()),
            InkWell(
              onTap: (){
                context.push(child: const TermsCondition());
              },
              child: bottomOption("Termos e Condições"),
            ),
            const MarginWidget(),
            sairDoAppBtn(),
            const MarginWidget(factor: 2),
          ],
        ),
      ),
    );
  }

  Widget sairDoAppBtn() => bottomOption("Sair do App");

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
                  "Ronaldo Silva",
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
                      CustomAssetImage(
                        path: AppIcons.upload,
                        height: 20,
                        width: 20,
                      ),
                      const MarginWidget(isHorizontal: true, factor: 0.7),
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

  Widget listTile(String header, String icon, {Function()? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Column(
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
      ),
    );
  }

  EdgeInsets padding2() => const EdgeInsets.only(left: 4, right: 4);

  Widget details() {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.only(left: padding, right: padding),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const MarginWidget(),
              TextFieldWidget(
                label: "Name",
                controller: name,
                hint: '',
                enabled: isEdit,
              ),
              const MarginWidget(),
              TextFieldWidget(
                  label: "E-mail",
                  controller: email,
                  enabled: isEdit,
                  hint: ', enabled: isEdit'),
              const MarginWidget(),
              TextFieldWidget(
                  label: "Número de Contato",
                  controller: phone,
                  hint: '',
                  enabled: isEdit),
              const MarginWidget(),
              TextFieldWidget(
                  label: "RG/CPF",
                  controller: rgController,
                  hint: '',
                  enabled: isEdit),
              const MarginWidget(),
              TextFieldWidget(
                  label: "Nº CNH",
                  controller: cnhController,
                  hint: '',
                  enabled: isEdit),
              const MarginWidget(),
              Row(
                children: [
                  CustomAssetImage(
                    path: AppIcons.timer,
                    height: 24,
                  ),
                  const MarginWidget(isHorizontal: true),
                  Text(
                    "CNH em análise",
                    style: AppTextStyles.captionMedium(color: CColors.primary),
                  ),
                ],
              ),
              const MarginWidget(),
              Text(
                "Endereço",
                style: AppTextStyles.titleMedium(),
              ),
              const MarginWidget(),
              TextFieldWidget(
                  label: "CEP",
                  controller: cEPController,
                  hint: '',
                  enabled: isEdit),
              const MarginWidget(),
              TextFieldWidget(
                  label: "Rua",
                  controller: ruaController,
                  hint: '',
                  enabled: isEdit),
              const MarginWidget(),
              TextFieldWidget(
                  label: "Bairro",
                  controller: bairroController,
                  hint: '',
                  enabled: isEdit),
              const MarginWidget(),
              Row(
                children: [
                  Expanded(
                    child: TextFieldWidget(
                        label: "Nº",
                        controller: nDegController,
                        hint: '',
                        enabled: isEdit),
                  ),
                  const MarginWidget(isHorizontal: true,),
                  Expanded(
                    child: TextFieldWidget(
                        label: "Complemento",
                        controller: nDegController,
                        hint: '',
                        enabled: isEdit),
                  ),
                ],
              ),
              const MarginWidget(),
              Text(
                "Valor por aula",
                style: AppTextStyles.titleMedium(),
              ),
              const MarginWidget(),
              TextFieldWidget(
                  label: "R\$ 50,00",
                  controller: nDegController,
                  hint: '',
                  enabled: isEdit),
              const MarginWidget(),
              Text(
                "Dados Bancários",
                style: AppTextStyles.titleMedium(),
              ),
              const MarginWidget(),
              TextFieldWidget(
                  label: "Banco",
                  controller: nDegController,
                  hint: '',
                  enabled: isEdit),
              const MarginWidget(),
              TextFieldWidget(
                  label: "Agência",
                  controller: nDegController,
                  hint: '',
                  enabled: isEdit),
              const MarginWidget(),
              TextFieldWidget(
                  label: "Conta",
                  controller: nDegController,
                  hint: '',
                  enabled: isEdit),
              const MarginWidget(factor: 2),
              Center(
                child: Column(
                  children: [
                    if (isEdit) ...[
                      ButtonWidget(
                          name: "Salvar Alterações",
                          onPressed: () {
                            setState(() {
                              isEdit = false;
                              isDetails = false;
                            });
                          }),
                    ] else ...[
                      InkWell(
                        onTap: () {
                          setState(() {
                            isEdit = !isEdit;
                          });
                        },
                        child: bottomOption("Editar dados"),
                      ),
                    ],
                    const MarginWidget(),
                    sairDoAppBtn(),
                    const MarginWidget(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}