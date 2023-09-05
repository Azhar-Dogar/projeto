import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:projeto/extras/app_textstyles.dart';
import 'package:projeto/provider/data_provider.dart';
import 'package:projeto/screens/splash_screen.dart';
import 'package:provider/provider.dart';
import 'extras/colors.dart';
import 'firebase_options.dart';


Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=> DataProvider()),
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
            )
          ),

          colorScheme: ColorScheme.fromSeed(seedColor: CColors.getMaterialColor()),
          useMaterial3: false,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
