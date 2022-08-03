import 'package:flutter/material.dart';

import 'constants.dart';

ThemeData get themeData => ThemeData(
      primarySwatch: Colors.deepOrange,
      backgroundColor: kOffWhite,
      fontFamily: "Almarai",
      textTheme: TextTheme(
        headline1: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: kNavyBlue,
        ),
        subtitle1: TextStyle(
          fontSize: 14,
          color: kDarKGrey,
        ),
        subtitle2: TextStyle(
          color: kNavy,
          fontWeight: FontWeight.w700,
          fontSize: 14,
        ),
      ),
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
