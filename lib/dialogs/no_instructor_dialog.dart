import 'package:flutter/material.dart';
import 'package:projeto/extras/app_textstyles.dart';
import 'package:projeto/generated/assets.dart';
import 'package:utility_extensions/utility_extensions.dart';

import '../extras/colors.dart';

class NoInstructorDialog extends StatelessWidget {
  const NoInstructorDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      elevation: 0,
      contentPadding: EdgeInsets.zero,
      backgroundColor: Colors.transparent,
      content: Stack(
        children: [
          Card(
            margin: EdgeInsets.only(top: 15),
            color: Colors.white,
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              margin: EdgeInsets.only(top: 35),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Por enquanto, não há instrutores por perto",
                    style: AppTextStyles.subTitleMedium(),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "O instrutor mais próximo entrará em contato para agendamento",
                    textAlign: TextAlign.center,
                    style: AppTextStyles.subTitleRegular(),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextButton(
                    onPressed: () {
                      context.pop();
                      // context.pop(rootNavigator: true);

                    },
                    child: Text(
                      "Procurar instrutor por nome",
                      style: AppTextStyles.captionMedium(
                        color: CColors.primary
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            child: Align(
              alignment: Alignment.topCenter,
              child: Image(
                image: AssetImage(
                  Assets.iconsInfoPopup,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
