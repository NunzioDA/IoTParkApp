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
    TextTheme textTheme = GoogleFonts.urbanistTextTheme();
    
    return MaterialApp(
      theme: ThemeData(
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Palette.primary,
            foregroundColor: Palette.onPrimaryText,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
        ),
        colorScheme: ColorScheme.of(context).copyWith(
          primary: Palette.primary, 
          onPrimary: Palette.onPrimaryText, 
          secondary: Palette.secondary,
        ),
        primaryColor: Palette.primary,
        textTheme: textTheme.copyWith(
              headlineLarge: textTheme.headlineLarge?.copyWith(
                  fontSize: 35,
                  fontWeight: FontWeight.w900,
                  color: Palette.headLine),
              headlineMedium: textTheme.headlineMedium?.copyWith(
                  fontSize: 30,
                  fontWeight: FontWeight.w800,
                  color: Palette.headLine),
              headlineSmall: textTheme.headlineSmall?.copyWith(
                  fontSize: 25,
                  fontWeight: FontWeight.w100,
                  color: Palette.headLine),
              titleLarge: textTheme.titleLarge?.copyWith(
                  fontSize: 25,
                  fontWeight: FontWeight.w800,
                  color: Palette.headLine),
              titleMedium: textTheme.titleMedium?.copyWith(
                  fontSize: 15,
                  fontWeight: FontWeight.w300,
                  letterSpacing: 1.2,
                  color: Colors.black
                ),
              titleSmall: textTheme.titleSmall?.copyWith(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Palette.headLine),
              bodyMedium: textTheme.bodySmall?.copyWith(
                  fontSize: 15,
                  fontWeight: FontWeight.w200,
                  color: Palette.text),
              labelLarge: textTheme.bodyMedium?.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.w100,
                  color: Palette.headLine),
            ),
      ),
      home: Home(),
    );
  }
}
