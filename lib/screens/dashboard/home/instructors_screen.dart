import 'package:flutter/material.dart';
import 'package:projeto/widgets/c_profile_app_bar.dart';
import 'package:projeto/widgets/instructor_widget.dart';
import 'package:projeto/widgets/margin_widget.dart';

import '../../../extras/app_assets.dart';
import '../../../extras/app_textstyles.dart';
import '../../../extras/colors.dart';

class InstructorsScreen extends StatelessWidget {
  const InstructorsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: CColors.dashboard,
      appBar: CustomAppBar("Instrutores"),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text("Instrutores na sua região",style: AppTextStyles.subTitleMedium(),),
          ),
          // InstructorWidget(name: "Cameron Williamson", imagePath: AppImages.instructor_2,showButton: true,),
            // InstructorWidget(name: "Jacob Jones", imagePath: AppImages.instructor_1,showButton: true,)
          ],),
      ),
    );
  }
}
