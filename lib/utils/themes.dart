import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:workflow_worker/utils/colors.dart';

final ThemeData lightTheme = ThemeData.light().copyWith(
  colorScheme: const ColorScheme(
    brightness: Brightness.light,
    primary: primaryColor,
    onPrimary: whiteColor,
    secondary: secondaryColor,
    onSecondary: secondaryColor,
    error: redColor,
    onError: redColor,
    background: whiteColor,
    onBackground: whiteColor,
    surface: whiteColor,
    onSurface: blackColor,
  ),
  primaryColor: primaryColor,
  secondaryHeaderColor: whiteColor,
  iconTheme: const IconThemeData(color: primaryColor),
  tabBarTheme: const TabBarTheme(labelColor: Colors.black),
  listTileTheme: const ListTileThemeData(iconColor: blackColor),
  brightness: Brightness.light,
  dividerColor: transparent,
  appBarTheme: const AppBarTheme(
    iconTheme: IconThemeData(color: primaryColor),
    titleTextStyle: TextStyle(color: primaryColor),
    systemOverlayStyle:
        SystemUiOverlayStyle(statusBarIconBrightness: Brightness.dark),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: whiteColor,
    selectedItemColor: bottomSelectedColor,
    unselectedItemColor: bottomUnselectedColor,
  ),
);

final ThemeData darkTheme = ThemeData.dark().copyWith(
  colorScheme: const ColorScheme(
    brightness: Brightness.light,
    primary: Colors.black,
    onPrimary: Colors.white,
    secondary: secondaryColor,
    onSecondary: secondaryColor,
    error: redColor,
    onError: redColor,
    background: whiteColor,
    onBackground: whiteColor,
    surface: greyColor,
    onSurface: blackColor,
  ),
  primaryColor: whiteColor,
  secondaryHeaderColor: primaryColor,
  iconTheme: const IconThemeData(color: whiteColor),
  brightness: Brightness.dark,
  tabBarTheme: const TabBarTheme(labelColor: Colors.white),
  listTileTheme: const ListTileThemeData(iconColor: whiteColor),
  dividerColor: transparent,
  dialogTheme: const DialogTheme(
    backgroundColor: Colors.grey,
    titleTextStyle: TextStyle(
      color: blackColor,
      fontWeight: FontWeight.w500,
      fontSize: 18,
    ),
    contentTextStyle: TextStyle(color: Colors.black),
  ),
  expansionTileTheme: const ExpansionTileThemeData(
      iconColor: whiteColor, textColor: whiteColor),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Colors.black,
    selectedItemColor: Colors.white,
    unselectedItemColor: Colors.grey.shade500,
  ),
  appBarTheme: const AppBarTheme(
    iconTheme: IconThemeData(color: whiteColor),
    titleTextStyle: TextStyle(color: whiteColor),
    systemOverlayStyle:
        SystemUiOverlayStyle(statusBarIconBrightness: Brightness.light),
  ),
);
