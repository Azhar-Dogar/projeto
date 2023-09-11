import 'package:flutter/material.dart';
import 'package:projeto/model/user_model.dart';
import 'package:projeto/provider/data_provider.dart';
import 'package:projeto/widgets/c_profile_app_bar.dart';
import 'package:projeto/widgets/instructor_widget.dart';
import 'package:projeto/widgets/margin_widget.dart';
import 'package:provider/provider.dart';
import 'package:utility_extensions/utility_extensions.dart';

import '../../../extras/app_assets.dart';
import '../../../extras/app_textstyles.dart';
import '../../../extras/colors.dart';

typedef InstructorValue = void Function(UserModel);

class InstructorsScreen extends StatelessWidget {
  const InstructorsScreen({super.key, required this.callBack});

  final InstructorValue callBack;

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
                  return InstructorWidget(
                    user: value.users[index],
                    toChoose: true,
                    onChoose: (user) {
                      callBack(user);
                      context.pop();
                    },
                  );
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
