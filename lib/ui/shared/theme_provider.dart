import 'package:flutter/material.dart';
import 'package:test_peanut/ui/shared/app_colors.dart';

class CustomThemeProvider extends ChangeNotifier {
  static final customLightTheme = ThemeData(
    scaffoldBackgroundColor: kScaffoldBackgroundColor,
    colorScheme: const ColorScheme.light().copyWith(
      secondary: kLightMainColor,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: kMainColor,
    ),
    tabBarTheme: const TabBarTheme(
      labelStyle: TextStyle(
        fontFamily: 'Quicksand',
      ),
    ),
    fontFamily: 'Quicksand',
    textTheme: const TextTheme(
      /// Medium Heading Black
      headlineMedium: TextStyle(
        color: kTextMainColor,
        fontWeight: FontWeight.w600,
      ),

      /// Small Heading Black
      headlineSmall: TextStyle(
        color: kTextMainColor,
        fontWeight: FontWeight.w600,
      ),

      /// Body Large Text
      bodyLarge: TextStyle(
        color: kTextMainColor,
        fontWeight: FontWeight.w600,
      ),

      /// Body Medium Text
      bodyMedium: TextStyle(
        color: kTextSecondaryColor,
        fontWeight: FontWeight.w500,
      ),

      /// Body Medium Text
      bodySmall: TextStyle(
        color: kTextSecondaryColor,
      ),
    ),
  );
}
