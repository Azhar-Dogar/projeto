import 'package:flutter/material.dart';
import 'package:projeto/screens/splash_screen.dart';

import 'extras/colors.dart';

void main() {
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
        colorScheme: ColorScheme.fromSeed(seedColor: CColors.primary),
        useMaterial3: false,
      ),
      home: const SplashScreen(),
    );
  }
}
