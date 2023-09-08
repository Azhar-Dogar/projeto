import 'package:flutter/material.dart';
import 'package:projeto/provider/data_provider.dart';
import 'package:projeto/widgets/c_profile_app_bar.dart';
import 'package:projeto/widgets/instructor_widget.dart';
import 'package:projeto/widgets/margin_widget.dart';
import 'package:provider/provider.dart';

import '../../../extras/app_assets.dart';
import '../../../extras/app_textstyles.dart';
import '../../../extras/colors.dart';

class InstructorsScreen extends StatelessWidget {
  const InstructorsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DataProvider>(builder: (context, value, child) {
      return Scaffold(
        backgroundColor: CColors.dashboard,
        appBar: CustomAppBar("Instrutores"),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                "Instrutores na sua região",
                style: AppTextStyles.subTitleMedium(),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemBuilder: (ctx, index) {
                  return InstructorWidget(user: value.users[index], toChoose: true,);
                },
                itemCount: value.users.length,
              ),
            ),


          ],
        ),
      );
    });
  }
}
