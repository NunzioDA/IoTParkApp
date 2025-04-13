import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iot_park_app/UIUtilities/palette.dart';
import 'package:iot_park_app/pages/home.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});


  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = GoogleFonts.outfitTextTheme();
    
    return MaterialApp(
      theme: ThemeData(
        textTheme: textTheme.copyWith(
              headlineLarge: textTheme.headlineLarge?.copyWith(
                  fontSize: 35,
                  fontWeight: FontWeight.w900,
                  color: Palette.primary),
              headlineMedium: textTheme.headlineMedium?.copyWith(
                  fontSize: 30,
                  fontWeight: FontWeight.w800,
                  color: Palette.primary.shade800),
              headlineSmall: textTheme.headlineSmall?.copyWith(
                  fontSize: 25,
                  fontWeight: FontWeight.w100,
                  color: Palette.primary.shade800),
              titleLarge: textTheme.titleLarge?.copyWith(
                  fontSize: 25,
                  fontWeight: FontWeight.w800,
                  color: Palette.primary),
              titleMedium: textTheme.titleMedium?.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Palette.primary.shade800),
              titleSmall: textTheme.titleSmall?.copyWith(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Palette.primary.shade800),
              bodyMedium: textTheme.bodySmall?.copyWith(
                  fontSize: 15,
                  fontWeight: FontWeight.w200,
                  color: Colors.grey),
              labelLarge: textTheme.bodyMedium?.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.w100,
                  color: Colors.grey),
            ),
      ),
      home: Home(),
    );
  }
}
