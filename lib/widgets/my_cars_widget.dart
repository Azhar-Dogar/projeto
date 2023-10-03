import 'package:flutter/material.dart';
import 'package:projeto/model/car_model.dart';
import 'package:projeto/screens/instructor/dashboard/add_car.dart';
import 'package:utility_extensions/utility_extensions.dart';

import '../extras/app_textstyles.dart';
import '../extras/colors.dart';
import '../generated/assets.dart';

class MyCarsWidget extends StatelessWidget {
  const MyCarsWidget({Key? key, required this.car}) : super(key: key);

  final CarModel car;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.push(
            child: AddCar(
          car: car,
        ));
      },
      child: Card(
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
                            if (car.isPrimary)
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
                            car.vehicleDocumentApproved == null
                                ? Icon(
                                    Icons.access_time,
                                    color: CColors.primary,
                                  )
                                : car.vehicleDocumentApproved!
                                    ? Icon(
                                        Icons.check,
                                        color: CColors.primary,
                                      )
                                    : Icon(
                                        Icons.close,
                                        color: CColors.primary,
                                      ),
                            const SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              child: Text(
                                "Documento",
                                style: AppTextStyles.captionMedium(),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          child: Row(
                            children: [
                              car.vehicleLicenseApproved == null
                                  ? Icon(
                                      Icons.access_time,
                                      color: CColors.primary,
                                    )
                                  : car.vehicleLicenseApproved!
                                      ? Icon(
                                          Icons.check,
                                          color: CColors.primary,
                                        )
                                      : Icon(
                                          Icons.close,
                                          color: CColors.primary,
                                        ),
                              const SizedBox(
                                width: 5,
                              ),
                              Expanded(
                                child: Text(
                                  "Licencimento",
                                  style: AppTextStyles.captionMedium(),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            car.vehicleInsuranceApproved == null
                                ? Icon(
                              Icons.access_time,
                              color: CColors.primary,
                            )
                                : car.vehicleInsuranceApproved!
                                ? Icon(
                              Icons.check,
                              color: CColors.primary,
                            )
                                : Icon(
                              Icons.close,
                              color: CColors.primary,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              child: Text(
                                "Seguro",
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
                      image: AssetImage("assets/cars/Jeep.jpg"),
                      fit: BoxFit.cover,
                    ),
                    // child: Image(
                    //   image: NetworkImage(car.vehiclePhoto!),
                    // ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
