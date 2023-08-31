import 'package:flutter/material.dart';
import 'package:projeto/extras/extensions.dart';

import '../../../../extras/app_textstyles.dart';
import '../../../../extras/colors.dart';

class ProfileHeaderWidget extends StatelessWidget {
  const ProfileHeaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: context.width * 0.04),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            "Crédito",
            style: AppTextStyles.captionMedium(),
          ),
          Text(
            "R\$ 800,00",
            style: AppTextStyles.subTitleMedium(color: CColors.primary),
          ),
        ],
      ),
    );
  }
}
