import 'package:flutter/material.dart';
import 'package:projeto/extras/app_textstyles.dart';
import 'package:projeto/extras/extensions.dart';
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
  TextEditingController cnhController = TextEditingController();
  String? groupValue;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const MarginWidget(
                factor: 3,
              ),
              CustomText(
                text: "Registration",
                fontSize: 22,
                fontWeight: FontWeight.w500,
              ),
              const MarginWidget(
                factor: 0.3,
              ),
              CustomText(
                text: "Include your details below",
                fontSize: 16,
                fontWeight: FontWeight.w300,
              ),
              const MarginWidget(
                factor: 1,
              ),
              CustomText(
                text: "personal data",
                fontSize: 22,
                fontWeight: FontWeight.w500,
              ),
              const MarginWidget(
                factor: 1,
              ),
              TextFieldWidget(
                  borderColor: CColors.textFieldBorder,
                  backColor: Colors.transparent,
                  label: "Full Name",
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
                  label: "Contact Number",
                  controller: phone,
                  hint: ''),
              const MarginWidget(
                factor: 1,
              ),
              TextFieldWidget(
                  borderColor: CColors.textFieldBorder,
                  backColor: Colors.transparent,
                  label: "RG/CPF",
                  controller: rgController,
                  hint: ''),
              const MarginWidget(
                factor: 1,
              ),
              TextFieldWidget(
                  borderColor: CColors.textFieldBorder,
                  backColor: Colors.transparent,
                  label: "Nº CNH",
                  controller: cnhController,
                  hint: ''),
              const MarginWidget(
                factor: 1,
              ),
              TextFieldWidget(
                  borderColor: CColors.textFieldBorder,
                  backColor: Colors.transparent,
                  label: "Driver's License Category",
                  controller: cnhController,
                  hint: ''),
              const MarginWidget(
                factor: 0.5,
              ),
              uploadDocument(),
              const MarginWidget(
                factor: 1.5,
              ),
              addressForm(),
              const MarginWidget(
                factor: 1.5,
              ),
              bankData(),
              const MarginWidget(
                factor: 1.5,
              ),
              radioButton(),
              const MarginWidget(
                factor: 1.5,
              ),
              ButtonWidget(name: "Register", onPressed: (){
                context.push(child: RegisterPassword());
              })
            ],
          ),
        ),
      ),
    );
  }

  Widget radioButton() {
    return Row(
      children: [
        Expanded(
          child: RadioListTile(
              contentPadding: EdgeInsets.zero,
              visualDensity: const VisualDensity(horizontal: -4),
              title: const Text("I'm a student"),
              value: "student",
              groupValue: groupValue,
              onChanged: (v) {
                setState(() {
                  groupValue = v.toString();
                });
              }),
        ),
        Expanded(
          child: RadioListTile(
              contentPadding: EdgeInsets.zero,
              visualDensity: const VisualDensity(horizontal: -4),
              title: Text(
                "I'm an instructor",
                style: AppTextStyles.poppins(
                    style:
                        const TextStyle(fontSize: 14, fontWeight: FontWeight.w400)),
              ),
              value: "instructor",
              groupValue: groupValue,
              onChanged: (v) {
                setState(() {
                  groupValue = v;
                });
              }),
        ),
      ],
    );
  }

  Widget uploadDocument() {
    return Row(
      children: [
        const Image(
          image: AssetImage("assets/icons/upload.png"),
          width: 20,
        ),
        const MarginWidget(
          isHorizontal: true,
        ),
        CustomText(
          text: "Upload CNH document",
          fontSize: 12,
          fontWeight: FontWeight.w500,
          textColor: CColors.primary,
        )
      ],
    );
  }

  Widget addressForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: "Address",
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        const MarginWidget(),
        TextFieldWidget(
            borderColor: CColors.textFieldBorder,
            backColor: Colors.transparent,
            label: "Zip Code",
            controller: cnhController,
            hint: ''),
        const MarginWidget(
          factor: 1,
        ),
        TextFieldWidget(
            borderColor: CColors.textFieldBorder,
            backColor: Colors.transparent,
            label: "Road",
            controller: cnhController,
            hint: ''),
        const MarginWidget(
          factor: 1,
        ),
        TextFieldWidget(
            borderColor: CColors.textFieldBorder,
            backColor: Colors.transparent,
            label: "Neighborhood",
            controller: cnhController,
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
                  label: "No",
                  controller: cnhController,
                  hint: ''),
            ),
            const MarginWidget(
              isHorizontal: true,
            ),
            Expanded(
              child: TextFieldWidget(
                  borderColor: CColors.textFieldBorder,
                  backColor: Colors.transparent,
                  label: "Complement",
                  controller: cnhController,
                  hint: ''),
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
          text: "Bank Data",
          fontWeight: FontWeight.w500,
          fontSize: 16,
        ),
        const MarginWidget(),
        TextFieldWidget(
            borderColor: CColors.textFieldBorder,
            backColor: Colors.transparent,
            label: "Bank",
            controller: cnhController,
            hint: ''),
        const MarginWidget(),
        TextFieldWidget(
            borderColor: CColors.textFieldBorder,
            backColor: Colors.transparent,
            label: "Agency",
            controller: cnhController,
            hint: ''),
        const MarginWidget(),
        TextFieldWidget(
            borderColor: CColors.textFieldBorder,
            backColor: Colors.transparent,
            label: "Account",
            controller: cnhController,
            hint: ''),
      ],
    );
  }
}
