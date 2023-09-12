import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projeto/extras/app_assets.dart';
import 'package:projeto/extras/app_textstyles.dart';
import 'package:projeto/extras/colors.dart';
import 'package:projeto/extras/constants.dart';
import 'package:projeto/generated/assets.dart';
import 'package:projeto/provider/data_provider.dart';
import 'package:projeto/screens/auth/login_screen.dart';
import 'package:projeto/widgets/drop_down_widget.dart';
import 'package:provider/provider.dart';
import 'package:utility_extensions/utility_extensions.dart';
import 'package:projeto/extras/functions.dart';
import 'package:projeto/screens/dashboard/profile/credit/balance.dart';
import 'package:projeto/screens/dashboard/profile/student_progress.dart';
import 'package:projeto/screens/dashboard/profile/terms_condition.dart';
import 'package:projeto/screens/dashboard/profile/widgets/profile_header_widget.dart';
import 'package:projeto/widgets/button_widget.dart';
import 'package:projeto/widgets/custom_asset_image.dart';
import 'package:projeto/widgets/margin_widget.dart';
import '../../model/user_model.dart';
import '../../widgets/textfield_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({
    super.key,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late double width, height, padding;

  bool isDetails = false, isEdit = false;

  late DataProvider provider;

  @override
  Widget build(BuildContext context) {
    width = context.width;
    height = context.height;
    padding = width * 0.04;

    return Consumer<DataProvider>(builder: (context, data, child) {
      provider = data;

      return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            const MarginWidget(factor: 3),
            const Align(
              alignment: Alignment.centerRight,
              child: ProfileHeaderWidget(),
            ),
            const MarginWidget(factor: 0.8),
            header(),
            isDetails ? details() : profileMain(),
          ],
        ),
      );
    });
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
                context.push(child: const StudentProgress());
              },
              child: listTile("Meu Progresso", AppIcons.trending),
            ),
            listTile("Carteira", AppIcons.brief),
            listTile("Inserir Crédito", AppIcons.dollar, onTap: () {
              Functions.push(context, const Balance());
            }),
            const Expanded(child: SizedBox()),
            InkWell(
              onTap: () {
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

  Widget sairDoAppBtn() {
    return InkWell(
      onTap: () {
        Constants.auth().signOut();
        Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (ctx) => const LoginScreen(),
            ),
            (route) => false);
      },
      child: bottomOption("Sair do App"),
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
                child: Image(
                  image: provider.userModel!.image == null ?
                  AssetImage(Assets.imagesPlaceHolder) : NetworkImage(provider.userModel!.image!) as ImageProvider,
                  fit: BoxFit.cover,
                )
              ),
            ),
            const MarginWidget(isHorizontal: true, factor: 1.4),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  provider.userModel!.name,
                  style: AppTextStyles.titleMedium(),
                ),
                const MarginWidget(factor: 0.7),
                InkWell(
                  onTap: () async {
                    var file = await Functions.pickImage();
                    if(file != null){
                      Functions.showLoading(context);
                      var link = await Functions.uploadImage(file, path: "profile/${Constants.uid()}.${file.path.split(".").last}");

                      Constants.users.doc(Constants.uid()).update({
                        "image" : link,
                      });

                      Navigator.of(context, rootNavigator: true).pop();

                    }

                  },
                  child: Container(
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
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: padding, right: padding),
          child: Column(
            children: [
              EditProfileForm(
                isEdit: isEdit,
                onSave: () {
                  setState(() {
                    isEdit = false;
                    isDetails = false;
                  });
                },
              ),
              const MarginWidget(factor: 2),
              Center(
                child: Column(
                  children: [
                    if (!isEdit) ...[
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EditProfileForm extends StatefulWidget {
  const EditProfileForm(
      {super.key, required this.isEdit, required this.onSave});

  final Function() onSave;
  final bool isEdit;

  @override
  State<EditProfileForm> createState() => _EditProfileFormState();
}

class _EditProfileFormState extends State<EditProfileForm> {
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

  setData() {
    var user = provider.userModel!;
    name.text = user.name;
    email.text = user.email;
    phone.text = user.phone;
    rgController.text = user.rgCpf;
    drivingLicenceNumber.text = user.licenceNumber;
    drivingLicenceCategory.text = user.licenseCategory;

    zipCode.text = user.zipCode;
    road.text = user.road;
    neighborhood.text = user.neighbourhood;
    number.text = user.number;
    complement.text = user.complement;
  }

  late DataProvider provider;

  bool isSet = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<DataProvider>(builder: (context, value, child) {
      provider = value;
      if (!isSet) {
        setData();
        isSet = true;
      }
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const MarginWidget(),
          TextFieldWidget(
            label: "Name",
            controller: name,
            hint: '',
            enabled: widget.isEdit,
          ),
          const MarginWidget(),
          TextFieldWidget(
            label: "E-mail",
            controller: email,
            enabled: false,
          ),
          const MarginWidget(),
          TextFieldWidget(
              label: "Número de Contato",
              controller: phone,
              hint: '',
              enabled: widget.isEdit),
          const MarginWidget(),
          TextFieldWidget(
              label: "RG/CPF",
              controller: rgController,
              hint: '',
              enabled: widget.isEdit),
          const MarginWidget(),
          TextFieldWidget(
            label: "Nº CNH",
            controller: drivingLicenceNumber,
            hint: '',
            enabled: widget.isEdit,
          ),
          const MarginWidget(),
          DropDownWidget(
            dropdownItems: Constants.drivingLicenseCategoriesPortugal,
            onSelect: (value) {
              drivingLicenceCategory.text = value;
            },
            isEdit: widget.isEdit,
            label: "Categoria da CNH",
            selectedValue: drivingLicenceCategory.text,
          ),
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
              controller: zipCode,
              hint: '',
              enabled: widget.isEdit),
          const MarginWidget(),
          TextFieldWidget(
              label: "Rua", controller: road, hint: '', enabled: widget.isEdit),
          const MarginWidget(),
          TextFieldWidget(
            label: "Bairro",
            controller: neighborhood,
            hint: '',
            enabled: widget.isEdit,
          ),
          const MarginWidget(),
          Row(
            children: [
              Expanded(
                child: TextFieldWidget(
                  label: "Nº",
                  controller: number,
                  hint: '',
                  enabled: widget.isEdit,
                ),
              ),
              const MarginWidget(
                isHorizontal: true,
              ),
              Expanded(
                child: TextFieldWidget(
                  label: "Complemento",
                  controller: complement,
                  hint: '',
                  enabled: widget.isEdit,
                ),
              ),
            ],
          ),
          const MarginWidget(),
          if (widget.isEdit)
            ButtonWidget(
              name: "Salvar Alterações",
              onPressed: () {
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
                  isUser: true,
                );

                Constants.users.doc(Constants.uid()).update(
                      model.toMapUserUpdate(),
                    );
                widget.onSave();
              },
            ),
        ],
      );
    });
  }
}
