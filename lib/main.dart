import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:projeto/extras/app_textstyles.dart';
import 'package:projeto/screens/splash_screen.dart';

import 'extras/colors.dart';
import 'firebase_options.dart';

Future<void> main() async {

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: CColors.white,
          elevation: 0,
          titleTextStyle: AppTextStyles.subTitleMedium(),
          iconTheme: IconThemeData(
            color: CColors.black,
          )
        ),

        colorScheme: ColorScheme.fromSeed(seedColor: CColors.getMaterialColor()),
        useMaterial3: false,
      ),
      home: const SplashScreen(),
    );
  }
}
