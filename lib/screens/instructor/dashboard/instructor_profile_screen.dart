import 'package:flutter/material.dart';
import 'package:projeto/extras/app_assets.dart';
import 'package:projeto/extras/app_textstyles.dart';
import 'package:projeto/extras/colors.dart';
import 'package:projeto/extras/constants.dart';
import 'package:projeto/model/user_model.dart';
import 'package:projeto/provider/data_provider.dart';
import 'package:projeto/screens/instructor/dashboard/my_cars.dart';
import 'package:projeto/screens/instructor/dashboard/profile/instructor_progress.dart';
import 'package:projeto/widgets/drop_down_widget.dart';
import 'package:provider/provider.dart';
import 'package:utility_extensions/utility_extensions.dart';
import 'package:projeto/extras/functions.dart';
import 'package:projeto/screens/dashboard/profile/terms_condition.dart';
import 'package:projeto/widgets/button_widget.dart';
import 'package:projeto/widgets/custom_asset_image.dart';
import 'package:projeto/widgets/margin_widget.dart';
import '../../../generated/assets.dart';
import '../../../widgets/textfield_widget.dart';
import '../../auth/login_screen.dart';

class InstructorProfileScreen extends StatefulWidget {
  const InstructorProfileScreen({super.key});

  @override
  State<InstructorProfileScreen> createState() =>
      _InstructorProfileScreenState();
}

class _InstructorProfileScreenState extends State<InstructorProfileScreen> {
  late double width, height, padding;

  bool isDetails = false, isEdit = false;

  late DataProvider dataProvider;

  late UserModel user;

  @override
  Widget build(BuildContext context) {
    width = context.width;
    height = context.height;
    padding = width * 0.04;

    return Consumer<DataProvider>(builder: (context, value, child) {
      dataProvider = value;
      user = dataProvider.userModel!;
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
                context.push(child: const MyCars());
              },
              child: listTile("Meus Veículos", AppIcons.carIcon),
            ),
            InkWell(
              onTap: () {
                context.push(child:  const InstructorProgress());
              },
              child: listTile("Minhas Avaliações", AppIcons.star),
            ),
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
                  image: user.image == null
                      ? const AssetImage(Assets.imagesPlaceHolder)
                      : NetworkImage(user.image!) as ImageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const MarginWidget(isHorizontal: true, factor: 1.4),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.name,
                  style: AppTextStyles.titleMedium(),
                ),
                const MarginWidget(factor: 0.7),
                InkWell(
                  onTap: () async {
                    var file = await Functions.pickImage();
                    if (file != null) {
                      Functions.showLoading(context);
                      var link = await Functions.uploadImage(file,
                          path:
                              "profile/${Constants.uid()}.${file.path.split(".").last}");

                      Constants.users.doc(Constants.uid()).update({
                        "image": link,
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
      child: Padding(
        padding: EdgeInsets.only(left: padding, right: padding),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const MarginWidget(factor: 2),
              Center(
                child: Column(
                  children: [
                    ProfileForm(
                        onSave: () {
                          setState(() {
                            isEdit = false;
                            isDetails = false;
                          });
                        },
                        isEdit: isEdit),
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
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileForm extends StatefulWidget {
  const ProfileForm({super.key, required this.onSave, required this.isEdit});

  final Function() onSave;
  final bool isEdit;

  @override
  State<ProfileForm> createState() => _ProfileFormState();
}

class _ProfileFormState extends State<ProfileForm> {
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



  //rate
  TextEditingController amount = TextEditingController();

  TextEditingController credential = TextEditingController();

  bool bankExist = true;

  setData() {
    var user = provider.userModel!;

    print(user.credential);
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

    credential.text = user.credential ?? "";
    bank.text = user.bank ?? "";
    if (user.bank!.isNotEmpty && !Constants.banksInPortugal.contains(bank.text)) {
      bankExist = false;
    }
    agency.text = user.agency ?? "";
    account.text = user.account ?? "";

    //rate
    amount.text = user.amount ?? "";
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
            enabled: widget.isEdit,
          ),
          const MarginWidget(),
          TextFieldWidget(
              label: "E-mail",
              controller: email,
              enabled: widget.isEdit,
              hint: ''),
          const MarginWidget(),
          TextFieldWidget(
              label: "Número de Contato",
              controller: phone,
              enabled: widget.isEdit),
          const MarginWidget(),
          TextFieldWidget(
              label: "RG/CPF",
              controller: rgController,
              enabled: widget.isEdit),
          const MarginWidget(),
          TextFieldWidget(
              label: "Nº CNH",
              controller: drivingLicenceNumber,
              enabled: widget.isEdit),
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
            enabled: widget.isEdit,
          ),
          const MarginWidget(),
          TextFieldWidget(
              label: "Rua", controller: road, enabled: widget.isEdit),
          const MarginWidget(),
          TextFieldWidget(
              label: "Bairro",
              controller: neighborhood,
              enabled: widget.isEdit),
          const MarginWidget(),
          Row(
            children: [
              Expanded(
                child: TextFieldWidget(
                    label: "Nº", controller: number, enabled: widget.isEdit),
              ),
              const MarginWidget(
                isHorizontal: true,
              ),
              Expanded(
                child: TextFieldWidget(
                    label: "Complemento",
                    controller: complement,
                    enabled: widget.isEdit),
              ),
            ],
          ),
          const MarginWidget(),
          Text(
            "Crdential",
            style: AppTextStyles.titleMedium(),
          ),
          const MarginWidget(),
          TextFieldWidget(
              label: "Nº Credential", controller: credential, enabled: widget.isEdit),
          const MarginWidget(),
          Row(
            children: [
              CustomAssetImage(
                path: AppIcons.timer,
                height: 24,
              ),
              const MarginWidget(isHorizontal: true),
              Text(
                "Crdential em análise",
                style: AppTextStyles.captionMedium(color: CColors.primary),
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
              label: "Valor", controller: amount, enabled: widget.isEdit),
          const MarginWidget(),
          Text(
            "Dados Bancários",
            style: AppTextStyles.titleMedium(),
          ),
          const MarginWidget(),
          DropDownWidget(
            dropdownItems: Constants.banksInPortugal,
            onSelect: (value) {
              bank.text = value;
            },
            isEdit: widget.isEdit,
            label: "Banco",
            selectedValue: bankExist ?  bank.text : null,
          ),
          const MarginWidget(),
          TextFieldWidget(
            label: "Agência",
            controller: agency,
            enabled: widget.isEdit,
          ),
          const MarginWidget(),
          TextFieldWidget(
            label: "Conta",
            controller: account,
            enabled: widget.isEdit,
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
                    isUser: false,
                    bank: bank.text,
                    agency: agency.text,
                    account: account.text,
                    amount: amount.text,
                    credential: credential.text
                  );

                  Constants.users.doc(Constants.uid()).update(
                        model.toMapInstructorUpdate(),
                      );
                  widget.onSave();
                }),
        ],
      );
    });
  }
}
