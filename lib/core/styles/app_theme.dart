import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFF5D9CEC);
  static const Color scaffoldBgColor = Color(0xFFDFECDB);
  static const Color greyColor = Color(0xFFC8C9CB);

static final ThemeData lightTheme = ThemeData(
  appBarTheme: AppBarTheme(
    backgroundColor: primaryColor,
    titleTextStyle: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
  ),
  scaffoldBackgroundColor:scaffoldBgColor ,
  canvasColor: Colors.white,
  bottomAppBarTheme: BottomAppBarTheme(
    shape: CircularNotchedRectangle(),
    elevation:20
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.transparent,
      elevation: 0,
      selectedItemColor: primaryColor,
      unselectedItemColor: greyColor,
      selectedIconTheme: IconThemeData(
        size: 28,
      )),
  textTheme: TextTheme(
    bodyLarge: TextStyle(fontSize: 18,fontWeight: FontWeight.w700,color: primaryColor),
    bodyMedium:TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: Colors.black)
  )
);
}