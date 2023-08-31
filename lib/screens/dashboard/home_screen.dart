import 'package:flutter/material.dart';
import 'package:projeto/extras/app_assets.dart';
import 'package:projeto/extras/extensions.dart';
import 'package:projeto/widgets/custom_text.dart';
import 'package:projeto/widgets/margin_widget.dart';

import '../../extras/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
              Container(
                child: Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: Image(image: AssetImage(AppImages.autoImage)),
            )),
            Positioned(
                bottom: 1,
                child: card())
            ],
          )
        ],
      ),
    );
  }
Widget card(){
    return Container(
      // width: context.width,
      margin: const EdgeInsets.symmetric(horizontal: 12),
      child: Card(child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
         Image(image: AssetImage(AppImages.clock),width: 60,),
          const MarginWidget(isHorizontal: true,),
          Column(   //comment
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            CustomText(text: "Next Class",fontSize: 14,fontWeight: FontWeight.w500,),
            CustomText(text: "June 30, 2023",fontSize: 12,fontWeight: FontWeight.w400,),
            CustomText(text: "10:20",fontSize: 12,fontWeight: FontWeight.w500,),
          ],)
        ],),
      ),),
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
