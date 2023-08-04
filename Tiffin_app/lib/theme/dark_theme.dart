// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

ThemeData dark = ThemeData(
  fontFamily: 'Poppins',
  // primaryColor: Color(0xFF82CAB6),
  primaryColor: Color(0xFFD90B20),

  accentColor: Color(0xFFfe0d26),
  brightness: Brightness.dark,
  scaffoldBackgroundColor: Color(0xFF2C2C2C),
  cardColor: Color(0xFF121212),
  cursorColor: Color(0xFFD90B20),
  hintColor: Color(0xFFE7F6F8),
  focusColor: Color(0xFFADC4C8),
  pageTransitionsTheme: PageTransitionsTheme(builders: {
    TargetPlatform.android: ZoomPageTransitionsBuilder(),
    TargetPlatform.iOS: ZoomPageTransitionsBuilder(),
    TargetPlatform.fuchsia: ZoomPageTransitionsBuilder(),
  }),
);
