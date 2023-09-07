import 'package:flutter/material.dart';
import 'package:projeto/model/car_model.dart';
import 'package:projeto/provider/data_provider.dart';
import 'package:projeto/screens/instructor/dashboard/add_car.dart';
import 'package:projeto/widgets/button_widget.dart';
import 'package:projeto/widgets/my_cars_widget.dart';
import 'package:provider/provider.dart';
import 'package:utility_extensions/utility_extensions.dart';

class MyCars extends StatefulWidget {
  const MyCars({Key? key}) : super(key: key);

  @override
  State<MyCars> createState() => _MyCarsState();
}

class _MyCarsState extends State<MyCars> {

  late DataProvider provider;
  @override
  Widget build(BuildContext context) {
    return Consumer<DataProvider>(
      builder: (context, value, child) {
        provider = value;
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
                      return MyCarsWidget(car: provider.cars[i],);
                    },
                    itemCount: provider.cars.length,
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
    );
  }
}
