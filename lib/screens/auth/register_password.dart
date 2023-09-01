import 'package:flutter/material.dart';
import 'package:projeto/extras/extensions.dart';
import 'package:projeto/screens/dashboard_screen.dart';
import 'package:projeto/widgets/button_widget.dart';
import 'package:projeto/widgets/custom_text.dart';
import 'package:projeto/widgets/margin_widget.dart';
import 'package:projeto/widgets/textfield_widget.dart';

import '../../extras/colors.dart';

class RegisterPassword extends StatefulWidget {
  const RegisterPassword({super.key, required this.isInstructor});

  final bool isInstructor;
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
                text: "Register Password",
                fontSize: 22,
                fontWeight: FontWeight.w500,
              ),
              const MarginWidget(
                factor: 1,
              ),
              CustomText(
                text: "Register a new password",
                fontWeight: FontWeight.w300,
              ),
              const MarginWidget(
                factor: 0.5,
              ),
              CustomText(
                text: "Password",
                fontWeight: FontWeight.w500,
              ),
              const MarginWidget(),
              TextFieldWidget(
                secureText: isShowCurrent,
                suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        isShowCurrent = !isShowCurrent;
                      });
                    },
                    icon: Icon(
                        (isShowCurrent) ? Icons.visibility_off : Icons.visibility)),
                controller: currentPassword,
                label: "Current Password",
                borderColor: CColors.textFieldBorder,
                labelColor: CColors.black,
              ),
              const MarginWidget(),
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
                label: "New Password",
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
                    icon: Icon(
                        (isShowConfirm) ? Icons.visibility_off : Icons.visibility)),
                controller: confirmPassword,
                label: "Confirm New Password",
                borderColor: CColors.textFieldBorder,
                labelColor: CColors.black,
              ),
              const Expanded(child: SizedBox()),
              ButtonWidget(name: "Register", onPressed: () {
                context.push(child: const DashBoard());
              })
            ],
          ),
        ),
      ),
    );
  }
}
