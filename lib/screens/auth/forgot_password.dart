import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projeto/extras/app_textstyles.dart';
import 'package:projeto/widgets/button_widget.dart';
import 'package:utility_extensions/extensions/context_extensions.dart';
import '../../extras/functions.dart';
import '../../widgets/margin_widget.dart';
import '../../widgets/textfield_widget.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController emailC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Esqueceu sua senha",
          style: AppTextStyles.titleMedium(),
        ),
      ),
      body: Padding(
        padding:
            const EdgeInsets.only(top: 80, bottom: 80, left: 25, right: 25),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const MarginWidget(factor: 1.5),
              Text(
                "Se você esqueceu sua senha, digite seu endereço de e-mail cadastrado e continue",
                style: AppTextStyles.captionRegular(size: 16),
              ),
              const MarginWidget(factor: 1.2),
              TextFieldWidget(controller: emailC, hint: "Email"),
              const MarginWidget(factor: 0.7),
              const MarginWidget(),
              ButtonWidget(
                name: "CONTINUAR",
                onPressed: () async {
                  if (emailC.text.isEmpty) {
                    Functions.showSnackBar(
                        context, "O e-mail não pode estar vazio");
                    return;
                  }

                  if (!EmailValidator.validate(emailC.text)) {
                    Functions.showSnackBar(
                        context, "por favor digite um email válido");
                    return;
                  }
                  try {
                    Functions.showLoading(context);
                    await FirebaseAuth.instance
                        .sendPasswordResetEmail(email: emailC.text);

                    Functions.showSnackBar(context,
                        "Um e-mail foi enviado para redefinir sua senha. Por favor cheque seu e-mail");
                    // ignore: use_build_context_synchronously
                    context.pop();
                    // ignore: use_build_context_synchronously
                    context.pop();
                  } on FirebaseException catch (e) {
                    context.pop();
                    Functions.showSnackBar(
                        context, e.message ?? "Algo deu errado");
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
