import 'package:flutter/material.dart';
import 'package:projeto/extras/app_textstyles.dart';
import 'package:projeto/extras/extensions.dart';
import 'package:projeto/screens/dashboard/profile/widgets/prodileAppBar.dart';
import 'package:projeto/screens/dashboard/profile_screen.dart';
import 'package:projeto/screens/dashboard_screen.dart';
import 'package:projeto/widgets/button_widget.dart';
import 'package:projeto/widgets/margin_widget.dart';

class SuccessMessage extends StatelessWidget {
  const SuccessMessage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = context.width;
    double padding = width * 0.04;

    return Scaffold(
      appBar: profileAppBar("Inserir Crédito"),
      body: Padding(
        padding: EdgeInsets.only(left: padding, right: padding),
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Text(
                  "Crédito inserido com sucesso",
                  style: AppTextStyles.titleMedium(),
                ),
              ),
            ),
            ButtonWidget(name: "Volta para pagamento", onPressed: (){
              context.pushAndRemoveUntil(child: const ProfileScreen());
            }),
            const MarginWidget(),
          ],
        ),
      ),
    );
  }
}
