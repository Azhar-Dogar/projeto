import 'package:flutter/material.dart';
import 'package:projeto/extras/app_assets.dart';
import 'package:projeto/extras/app_textstyles.dart';
import 'package:projeto/extras/extensions.dart';
import 'package:projeto/screens/dashboard/home/search_instructor.dart';
import 'package:projeto/widgets/button_widget.dart';
import 'package:projeto/widgets/calendar_widget.dart';
import 'package:projeto/widgets/instructor_widget.dart';
import 'package:projeto/widgets/margin_widget.dart';
import 'package:projeto/widgets/textfield_widget.dart';

import '../../../extras/colors.dart';

class SchedulingScreen extends StatefulWidget {
  const SchedulingScreen({super.key});

  @override
  State<SchedulingScreen> createState() => _SchedulingScreenState();
}

class _SchedulingScreenState extends State<SchedulingScreen> {
  bool sentMessage = false;
  TextEditingController time = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CColors.dashboard,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: CColors.white,
        centerTitle: true,
         leading:  IconButton(icon: Icon(Icons.arrow_back,color: CColors.black,),onPressed: (){
           context.pop();
         },),
        title: Text(
          "Agendamento",
          style: AppTextStyles.captionMedium(size: 14),
        ),
        actions: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Credit",
                style: AppTextStyles.captionMedium(),
              ),
              Text(
                "R\$ 800,00",
                style: AppTextStyles.captionMedium(color: CColors.primary),
              )
            ],
          )
        ],
      ),
      body: (!sentMessage)
          ? SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      color: CColors.white,
                      child:  Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5.0),
                            child: CalendarWidget(),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12.0),
                            child: Text("Abrir Calendário",style: AppTextStyles.captionMedium(color: CColors.primary),),
                          )
                        ],
                      )),
                  InstructorWidget(
                    name: "Annette Johnson",
                    imagePath: AppImages.instructor,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Trocar Instrutor",
                        style:
                            AppTextStyles.captionMedium(color: CColors.primary),
                      ),
                    ],
                  ),
                  const MarginWidget(),
                  informationWidget()
                ],
              ),
          )
          : confirmMessage(),
    );
  }

  Widget informationWidget() {
    return Card(
      color: CColors.white,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Informações da Aula",
              style: AppTextStyles.subTitleMedium(),
            ),
            const MarginWidget(),
            TextFieldWidget(
              controller: time,
              borderColor: CColors.textFieldBorder,
              label: "Horário",
              suffixIcon: const Icon(Icons.keyboard_arrow_down),
            ),
            const MarginWidget(),
            TextFieldWidget(
                controller: time,
                borderColor: CColors.textFieldBorder,
                label: "Quantidade de Aulas",
                suffixIcon: const Icon(Icons.keyboard_arrow_down)),
            const MarginWidget(),
            TextFieldWidget(
              controller: time,
              borderColor: CColors.textFieldBorder,
              label: "Valor Total",
            ),
            const MarginWidget(),
            ButtonWidget(
                name: "Confirmar",
                onPressed: () {
                  context.push(child: SearchInstructor());
                  // setState(() {
                  //   sentMessage = true;
                  // });
                })
          ],
        ),
      ),
    );
  }

  Widget confirmMessage() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: (){
            setState(() {
              sentMessage = false;
            });
          },
          child: Container(
            margin: const EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: CColors.checkBackground,
            ),
            child: const Padding(
              padding: EdgeInsets.all(4.0),
              child: Icon(
                Icons.check,
              ),
            ),
          ),
        ),
        Text(
          "Sua solicitação de aula foi enviada",
          style: AppTextStyles.subTitleMedium(size: 16),
        ),
        const MarginWidget(),
        Text(
          textAlign:TextAlign.center,
          "Quando o instrutor confirmar sua aula, você receberá uma notificaçã",
          style: AppTextStyles.captionMedium(size: 14),
        )
      ],
    );
  }
}
