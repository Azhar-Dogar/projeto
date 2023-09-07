import 'package:flutter/material.dart';
import 'package:projeto/model/car_model.dart';

import '../extras/app_textstyles.dart';
import '../extras/colors.dart';
import '../generated/assets.dart';

class MyCarsWidget extends StatelessWidget {
  const MyCarsWidget({Key? key, required this.car}) : super(key: key);

  final CarModel car;
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          20,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            car.vehicle,
                            style: AppTextStyles.titleMedium(),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 10),
                            padding: EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              color: CColors.primary.withOpacity(0.4),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              "Principal",
                              style: AppTextStyles.captionRegular(),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        car.year,
                        style: AppTextStyles.subTitleRegular(),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.arrow_forward_ios)
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.check,
                            color: CColors.primary,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            child: Text("Documento",
                              style: AppTextStyles.captionMedium(),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          children: [
                            Icon(
                              Icons.check,
                              color: CColors.primary,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              child: Text("Licencimento",
                                style: AppTextStyles.captionMedium(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.check,
                            color: CColors.primary,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            child: Text("Seguro",
                              style: AppTextStyles.captionMedium(),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 113,
                  height: 120,
                  padding: const EdgeInsets.all(
                    5,
                  ),
                  decoration: BoxDecoration(
                    color: CColors.paymentContainer,
                    borderRadius: BorderRadius.circular(
                      10,
                    ),
                  ),
                  child: Image(
                    image: NetworkImage(car.vehiclePhoto!),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
