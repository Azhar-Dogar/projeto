import 'package:flutter/material.dart';
import 'package:projeto/extras/app_textstyles.dart';
import 'package:projeto/extras/constants.dart';
import 'package:projeto/screens/auth/login_screen.dart';
import 'package:projeto/screens/check_data.dart';
import 'package:utility_extensions/utility_extensions.dart';

import '../generated/assets.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late double width, height;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1)).then((value) {
      if (Constants.user() == null) {
        context.pushAndRemoveUntil(child: LoginScreen());
      } else {
        context.pushAndRemoveUntil(child: CheckData());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      // backgroundColor: Colors.black,
      body: Stack(children: [
        Image(
          image: const AssetImage("assets/images/splash_image.png"),
          height: height,
          width: width,
          fit: BoxFit.cover,
        ),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                image: AssetImage(Assets.imagesLogo),
              ),
              SizedBox(height: height * 0.6),
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: RichText(
                  text: TextSpan(
                      style: AppTextStyles.poppins(
                          style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 28,
                      )),
                      text: "O controle da ",
                      children: const [
                        TextSpan(
                          text: "direção ",
                          style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.w600,
                            fontSize: 28,
                          ),
                        ),
                        TextSpan(text: "em suas mãos")
                      ]),
                ),
              ),
            ],
          ),
        )
      ]),
    );
  }
}
