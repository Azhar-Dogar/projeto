import 'package:flutter/material.dart';
import 'package:projeto/extras/extensions.dart';
import 'package:projeto/screens/auth/signup_screen.dart';
import 'package:projeto/widgets/button_widget.dart';
import 'package:projeto/widgets/margin_widget.dart';
import 'package:projeto/widgets/textfield_widget.dart';

import '../../extras/app_textstyles.dart';
import '../../extras/colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  late double width, height;
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: SingleChildScrollView(
      child: SizedBox(
        height: height,
        child: Stack(children: [
          Positioned.fill(
            child: Image(
              image: const AssetImage("assets/images/splash_image.png"),
              height: height,
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: width * 0.14,
                    child: Text(
                      "Logo",
                      style: AppTextStyles.poppins(
                          style: const TextStyle(
                              fontWeight: FontWeight.w300, fontSize: 28)),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.3,
                  ),
                  richText(),
                  const MarginWidget(factor: 1.5  ,),
                  TextFieldWidget(
                      backColor: Colors.transparent,
                      label: "Email",
                      controller: emailController,
                      hint: ''),
                  const MarginWidget(factor: 1,),
                  TextFieldWidget(
                      backColor: Colors.transparent,
                      label: "Senha",
                      controller: passwordController,
                      hint: ''),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "Esqueceu a senha?",
                        style: AppTextStyles.poppins(
                            style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Colors.white)),
                      ),
                    ],
                  ),
                  const MarginWidget(factor: 1.5  ,),
                  ButtonWidget(name: "Enter", onPressed: (){
                    context.push(child: const SignupScreen());
                  }),
                  const MarginWidget(factor: 0.5,),
                  Text(
                    "Não tem cadastro?",
                    style: AppTextStyles.poppins(
                        style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.white)),
                  ),
                ],
              ),
            ),
          )
        ]),
      ),
    ));
  }

  Widget richText() {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: RichText(
        text: TextSpan(
            style: AppTextStyles.poppins(
                style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 28,
            )),
            text: "O controle da ",
            children: const [
              TextSpan(
                  text: "direção ",
                  style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.w600,
                    fontSize: 28,
                  )),
              TextSpan(text: "em suas mãos")
            ]),
      ),
    );
  }
}
