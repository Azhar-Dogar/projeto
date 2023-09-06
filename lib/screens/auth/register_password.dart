import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projeto/extras/constants.dart';
import 'package:projeto/extras/functions.dart';
import 'package:projeto/model/user_model.dart';
import 'package:projeto/screens/check_data.dart';
import 'package:utility_extensions/utility_extensions.dart';
import 'package:projeto/widgets/button_widget.dart';
import 'package:projeto/widgets/custom_text.dart';
import 'package:projeto/widgets/margin_widget.dart';
import 'package:projeto/widgets/textfield_widget.dart';

import '../../extras/colors.dart';

class RegisterPassword extends StatefulWidget {
  const RegisterPassword({
    super.key,
    this.user,
  });

  final UserModel? user;

  @override
  State<RegisterPassword> createState() => _RegisterPasswordState();
}

class _RegisterPasswordState extends State<RegisterPassword> {
  TextEditingController currentPassword = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  bool isShowNew = false;
  bool isShowCurrent = false;
  bool isShowConfirm = false;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const MarginWidget(
                factor: 1,
              ),
              CustomText(
                text: "Cadastrar senha",
                fontSize: 22,
                fontWeight: FontWeight.w500,
              ),
              const MarginWidget(
                factor: 1,
              ),
              CustomText(
                text: "Cadastre uma nova senha",
                fontWeight: FontWeight.w300,
              ),
              const MarginWidget(
                factor: 0.5,
              ),
              CustomText(
                text: "Senha",
                fontWeight: FontWeight.w500,
              ),
              const MarginWidget(),
              if (widget.user == null) ...[
                TextFieldWidget(
                  secureText: isShowCurrent,
                  suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          isShowCurrent = !isShowCurrent;
                        });
                      },
                      icon: Icon((isShowCurrent)
                          ? Icons.visibility_off
                          : Icons.visibility)),
                  controller: currentPassword,
                  label: "Senha Atual",
                  borderColor: CColors.textFieldBorder,
                  labelColor: CColors.black,
                ),
                const MarginWidget(),
              ],
              TextFieldWidget(
                secureText: isShowNew,
                suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        isShowNew = !isShowNew;
                      });
                    },
                    icon: Icon(
                        (isShowNew) ? Icons.visibility_off : Icons.visibility)),
                controller: newPassword,
                label: "Nova Senha",
                borderColor: CColors.textFieldBorder,
                labelColor: CColors.black,
              ),
              const MarginWidget(),
              TextFieldWidget(
                secureText: isShowConfirm,
                suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        isShowConfirm = !isShowConfirm;
                      });
                    },
                    icon: Icon((isShowConfirm)
                        ? Icons.visibility_off
                        : Icons.visibility)),
                controller: confirmPassword,
                label: "Confirmar Nova Senha",
                borderColor: CColors.textFieldBorder,
                labelColor: CColors.black,
              ),
              const Expanded(child: SizedBox()),
              ButtonWidget(
                name: "Cadastrar",
                onPressed: () async {

                  if(widget.user != null){
                    if (newPassword.text.trim().length < 6) {
                      Functions.showSnackBar(context,
                          "a senha deve conter pelo menos 6 caracteres.");
                    } else if (newPassword.text.trim() !=
                        confirmPassword.text.trim()) {
                      Functions.showSnackBar(context, "A senha não corresponde.");
                    } else {

                      Functions.showLoading(context);
                      var user = widget.user!;
                      if (await createUser()) {
                        var imageDocumentLink = await Functions.uploadFile(user.licenseDocumentFile!, path: "licenseDocument/${Constants.uid()}.${user.licenseDocumentFile!.path.split(".").last}");
                        user.licenseDocument = imageDocumentLink;



                        // vehicleDocument;
                        // File? vehicleLicense;
                        // File? vehicleInsurance;
                        // File? leaseAgreement;
                        user.vehiclePhoto = user.vehiclePhotoFile == null ? null : await Functions.uploadFile(user.vehiclePhotoFile!, path: "vehiclePhoto/${Constants.uid()}.${user.vehiclePhotoFile!.path.split(".").last}");
                        user.vehicleDocument = user.vehicleDocumentFile == null ? null : await Functions.uploadFile(user.vehicleDocumentFile!, path: "vehiclePhoto/${Constants.uid()}.${user.vehicleDocumentFile!.path.split(".").last}");
                        user.vehicleLicense = user.vehicleLicenseFile == null ? null : await Functions.uploadFile(user.vehicleLicenseFile!, path: "vehiclePhoto/${Constants.uid()}.${user.vehicleLicenseFile!.path.split(".").last}");
                        user.vehicleInsurance = user.vehicleInsuranceFile == null ? null : await Functions.uploadFile(user.vehicleInsuranceFile!, path: "vehiclePhoto/${Constants.uid()}.${user.vehicleInsuranceFile!.path.split(".").last}");
                        user.leaseAgreement = user.leaseAgreementFile == null ? null : await Functions.uploadFile(user.leaseAgreementFile!, path: "vehiclePhoto/${Constants.uid()}.${user.leaseAgreementFile!.path.split(".").last}");

                  Constants.users.doc(Constants.uid()).set(user.isUser ? user.toMapUserCreate() : user.toMapInstructorCreate());
                  context.pushAndRemoveUntil(child: CheckData());
                  }else{
                  context.pop();
                  }
                }
                  }

                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> createUser() async {
    try{
      await Constants.auth().createUserWithEmailAndPassword(
        email: widget.user!.email,
        password: newPassword.text.trim(),
      );
      return true;
    }catch(e){
      var exception = e as FirebaseAuthException;
      Functions.showSnackBar(context, exception.message ?? "");
      return false;
    }

  }
}
