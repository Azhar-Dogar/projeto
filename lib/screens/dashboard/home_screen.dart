import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:projeto/extras/app_assets.dart';
import 'package:projeto/extras/app_textstyles.dart';
import 'package:projeto/extras/extensions.dart';
import 'package:projeto/extras/functions.dart';
import 'package:projeto/screens/dashboard/home/instructors_screen.dart';
import 'package:projeto/screens/dashboard/home/scheduling.dart';
import 'package:projeto/widgets/button_widget.dart';
import 'package:projeto/widgets/custom_text.dart';
import 'package:projeto/widgets/instructor_widget.dart';
import 'package:projeto/widgets/margin_widget.dart';
import 'package:projeto/widgets/textfield_widget.dart';

import '../../extras/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const MarginWidget(
              factor: 2,
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: header(),
            ),
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Image(image: AssetImage(AppImages.autoImage)),
                ),
                Positioned(bottom: 1, left: 5, right: 5, child: card()),
              ],
            ),
            const MarginWidget(),
            InkWell(
              onTap: (){
                Functions.push(context, InstructorsScreen());
              },
              child: Text(
                "Search instructors near me",
                style: AppTextStyles.captionMedium(color: CColors.primary),
              ),
            ),
            searchBar(),
            InstructorWidget(name:"Annette Johnson",imagePath:AppImages.instructor,showButton: true,),
            const MarginWidget(),
            InstructorWidget(name:"Jacob Jones",imagePath: AppImages.instructor_1,showButton: true,)
          ],
        ),
      ),
    );
  }

  Widget searchBar() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12), color: CColors.dashboard),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: TextFieldWidget(
          fontSize: 12,
          hint: "Enter an instructor's name",
          prefixWidget: Icon(
            Icons.search,
            color: CColors.textFieldBorder,
          ),
          controller: searchController,
          borderColor: CColors.dashboard,
        ),
      ),
    );
  }

  Widget card() {
    return SizedBox(
      width: context.width,
      // margin: const EdgeInsets.only(right: 5),
      child: Card(
        color: CColors.white,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image(
                image: AssetImage(AppImages.clock),
                width: 60,
              ),
              const MarginWidget(
                isHorizontal: true,
                factor: 1.5,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: "Next Class",
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    const MarginWidget(
                      factor: 0.3,
                    ),
                    CustomText(
                      text: "June 30, 2023",
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                    const MarginWidget(
                      factor: 0.3,
                    ),
                    CustomText(
                      text: "10:20",
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                ),
              ),
              Text(
                "see classes",
                style:
                    AppTextStyles.captionMedium(color: CColors.textFieldBorder),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget header() {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CircleAvatar(
            radius: 20, backgroundImage: AssetImage(AppImages.profile)),
        const MarginWidget(
          isHorizontal: true,
        ),
        Expanded(
            child: CustomText(
          text: "Claudia\nsilva",
          fontSize: 12,
          fontWeight: FontWeight.w500,
        )),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: "Credit",
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
              CustomText(
                text: "R\$ 800,00",
                fontSize: 14,
                fontWeight: FontWeight.w500,
                textColor: CColors.primary,
              )
            ],
          ),
        ),
        const MarginWidget(
          factor: 5,
          isHorizontal: true,
        ),
        Image(
          image: AssetImage(AppIcons.notification),
          color: CColors.black,
          width: 30,
        )
      ],
    );
  }
}
