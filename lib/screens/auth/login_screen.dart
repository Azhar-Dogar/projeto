import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projeto/extras/constants.dart';
import 'package:projeto/extras/functions.dart';
import 'package:projeto/generated/assets.dart';
import 'package:projeto/screens/auth/forgot_password.dart';
import 'package:projeto/screens/auth/signup_screen.dart';
import 'package:projeto/screens/check_data.dart';
import 'package:utility_extensions/utility_extensions.dart';
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
                  Image(
                    image: AssetImage(Assets.imagesLogo),

                  ),
                  // CircleAvatar(
                  //   backgroundColor: Colors.white,
                  //   radius: width * 0.14,
                  //   child: Text(
                  //     "Logo",
                  //     style: AppTextStyles.poppins(
                  //         style: const TextStyle(
                  //             fontWeight: FontWeight.w300, fontSize: 28)),
                  //   ),
                  // ),
                  SizedBox(
                    height: height * 0.3,
                  ),
                  richText(),
                  const MarginWidget(
                    factor: 1.5,
                  ),
                  Container(
                    decoration: BoxDecoration(),
                  ),
                  TextFieldWidget(
                    backColor: Colors.transparent,
                    borderColor: Colors.white,
                    labelColor: Colors.white,
                    label: "Email",
                    controller: emailController,
                    textColor: Colors.white,
                  ),
                  const MarginWidget(
                    factor: 1,
                  ),
                  TextFieldWidget(
                    backColor: Colors.transparent,
                    label: "Senha",
                    borderColor: Colors.white,
                    labelColor: Colors.white,
                    controller: passwordController,
                    textColor: Colors.white,
                    secureText: true,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {
                          context.push(child: ForgotPassword());
                        },
                        child: Text(
                          "Esqueceu a senha?",
                          style: AppTextStyles.poppins(
                              style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white)),
                        ),
                      ),
                    ],
                  ),
                  const MarginWidget(
                    factor: 1.5,
                  ),
                  ButtonWidget(
                      name: "Enter",
                      onPressed: () {
                        if (!emailController.text.trim().isValidEmail) {
                          Functions.showSnackBar(context,
                              "Por favor insira um endereço de e-mail válido.");
                        } else if (passwordController.text.trim().length < 6) {
                          Functions.showSnackBar(context,
                              "a senha deve conter pelo menos 6 caracteres.");
                        } else {
                          login();
                        }
                      }),
                  const MarginWidget(
                    factor: 0.5,
                  ),
                  InkWell(
                    onTap: () {
                      context.push(child: const SignupScreen());
                    },
                    child: Text(
                      "Não tem cadastro?",
                      style: AppTextStyles.poppins(
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Colors.white)),
                    ),
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

  login() {
    Functions.showLoading(context);
    Constants.auth()
        .signInWithEmailAndPassword(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    )
        .then((value) {
      context.pushAndRemoveUntil(child: const CheckData());
    }).catchError((error) {
      context.pop();
      var e = error as FirebaseAuthException;
      switch (e.code) {
        case "user-not-found":
          Functions.showSnackBar(context,
              "E-mail inválido. Nenhum usuário encontrado com este e-mail");
          break;
        case "wrong-password":
          Functions.showSnackBar(context, "Senha errada digitada");
          break;
        default:
          Functions.showSnackBar(context, "Incapaz de entrar. Algo deu errado");
          break;
      }
    });
  }
}
