import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projeto/extras/app_textstyles.dart';
import 'package:projeto/extras/constants.dart';
import 'package:projeto/model/brand_model.dart';
import 'package:projeto/provider/dashboard_provider.dart';
import 'package:projeto/provider/data_provider.dart';
import 'package:projeto/screens/splash_screen.dart';
import 'package:provider/provider.dart';
import 'extras/colors.dart';
import 'extras/time_ago_text.dart';
import 'firebase_options.dart';
import 'package:timeago/timeago.dart' as timeago;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  getBrands();

  timeago.setLocaleMessages('pt', MyCustomMessages());

  runApp(const MyApp());
}

getBrands() async {
  List<BrandModel> brands = [];
  final String data = await rootBundle.loadString('assets/json/brands.json');

  var d = jsonDecode(data) as Map;

  d.forEach((key, value) {
    var name = key;
    List list = value;
    List<String> vehicles = List<String>.generate(list.length, (index) => list[index]);
    brands.add(BrandModel(brand: name, vehicles: vehicles));
  });

  Constants.brands = brands;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DataProvider()),
        ChangeNotifierProvider(create: (_) => DashboardProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        locale: const Locale("pt"),
        theme: ThemeData(
          appBarTheme: AppBarTheme(
              backgroundColor: CColors.white,
              elevation: 0,
              titleTextStyle: AppTextStyles.subTitleMedium(),
              iconTheme: IconThemeData(
                color: CColors.black,
              )),
          colorScheme:
              ColorScheme.fromSeed(seedColor: CColors.getMaterialColor()),
          useMaterial3: false,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
