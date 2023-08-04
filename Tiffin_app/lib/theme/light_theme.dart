// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

ThemeData light = ThemeData(
  fontFamily: 'Poppins',
  // primaryColor: Color(0xFF01684B),
  primaryColor: Color(0xFFD90B20),

  accentColor: Color(0xFFfe0d26),
  brightness: Brightness.light,
  cardColor: Colors.white,
  cursorColor: Color(0xFFD90B20),
  focusColor: Color(0xFFADC4C8),
  hintColor: Color(0xFF52575C),
  pageTransitionsTheme: PageTransitionsTheme(builders: {
    TargetPlatform.android: ZoomPageTransitionsBuilder(),
    TargetPlatform.iOS: ZoomPageTransitionsBuilder(),
    TargetPlatform.fuchsia: ZoomPageTransitionsBuilder(),
  }),
);
