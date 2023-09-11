import 'package:flutter/material.dart';
import 'package:projeto/extras/app_assets.dart';
import 'package:projeto/extras/app_textstyles.dart';
import 'package:projeto/provider/data_provider.dart';
import 'package:provider/provider.dart';
import 'package:utility_extensions/utility_extensions.dart';
import 'package:projeto/extras/functions.dart';
import 'package:projeto/screens/dashboard/home/instructors_screen.dart';
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

  late DataProvider dataProvider;

  @override
  Widget build(BuildContext context) {
    return Consumer<DataProvider>(builder: (context, value, child) {
      dataProvider = value;

      return Scaffold(
        body: CustomScrollView(
          slivers: [
            const MarginWidget(
              factor: 2,
              isSliver: true,
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: header(),
            ).toSliver,
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Image(image: AssetImage(AppImages.autoImage)),
                ),
                Positioned(bottom: 1, left: 5, right: 5, child: card()),
              ],
            ).toSliver,
            const MarginWidget(
              isSliver: true,
            ),
            InkWell(
              onTap: () {
                // Functions.push(context, InstructorsScreen());
              },
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  "Pesquisar instrutores perto de mim",
                  style: AppTextStyles.captionMedium(color: CColors.primary),
                ),
              ),
            ).toSliver,
            searchBar().toSliver,
            Builder(builder: (context) {
              var instructors = dataProvider.users;

              if(searchController.text.trim().isNotEmpty){
                instructors = instructors.where((element) => element.name.toLowerCase().contains(searchController.text.toLowerCase())).toList();
              }

              return SliverList(
                delegate: SliverChildBuilderDelegate((ctx, i) {
                  return InstructorWidget(
                    toChoose: false,
                    user: instructors[i],
                  );
                }, childCount: instructors.length),
              );
            }),
          ],
        ),
      );
    });
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
          hint: "Digitar o nome de um instrutor",
          prefixWidget: Icon(
            Icons.search,
            color: CColors.textFieldBorder,
          ),
          controller: searchController,
          borderColor: CColors.dashboard,
          onChanged: (value) {
            setState(() {});
          },
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
                      text: "Próxima aula",
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
                "Ver aulas",
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
          text: "${dataProvider.userModel!.name}",
          fontSize: 12,
          fontWeight: FontWeight.w500,
        )),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: "Crédito",
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
              CustomText(
                text: "R\$ ${dataProvider.userModel!.credits}",
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
