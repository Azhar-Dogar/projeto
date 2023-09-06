import 'package:flutter/material.dart';
import 'package:projeto/screens/instructor/dashboard/add_car.dart';
import 'package:projeto/widgets/button_widget.dart';
import 'package:projeto/widgets/my_cars_widget.dart';
import 'package:utility_extensions/utility_extensions.dart';

class MyCars extends StatelessWidget {
  const MyCars({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Meus Veículos"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(vertical: 10),
                itemBuilder: (ctx, i) {
                  return MyCarsWidget();
                },
                itemCount: 3,
              ),
            ),
            ButtonWidget(
              name: "Adicionar Veículo",
              onPressed: () {
                context.push(child: AddCar());
              },
            ),
          ],
        ),
      ),
    );
  }
}
