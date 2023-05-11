import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';

import 'screens/bisection.dart';
import 'screens/bisection_info.dart';
import 'screens/home.dart';

void main() {
  runApp(const MyApp());
}

Color brandColor = Color.fromARGB(255, 52, 194, 226);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
        builder: (ColorScheme? lightDynamic, ColorScheme? dark) {
      ColorScheme lightColorScheme;
      ColorScheme darkColorScheme;
      if (lightDynamic != null && dark != null) {
        lightColorScheme = lightDynamic.harmonized()..copyWith();
        lightColorScheme = lightColorScheme.copyWith(secondary: brandColor);
        darkColorScheme = dark.harmonized();
      } else {
        lightColorScheme = ColorScheme.fromSeed(seedColor: brandColor);
        darkColorScheme = ColorScheme.fromSeed(
            seedColor: brandColor, brightness: Brightness.dark);
      }
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Numerical Methods',
        theme: ThemeData(useMaterial3: true, colorScheme: lightColorScheme),
        darkTheme: ThemeData.dark(useMaterial3: true),
        initialRoute: '/',
        routes: {
          '/': (context) => const HomePage(),
          '/bisection_method': (context) => const Bisection(),
          '/bisection_info': (context) => const BisectionInfo(),
          //'/regula_falsi_method': (BuildContext context) => RegulaFalsi(),
          //'/regula_falsi_info':(context) => const RegulaFalsiInfo(),
        },
      );
    });
  }
}
