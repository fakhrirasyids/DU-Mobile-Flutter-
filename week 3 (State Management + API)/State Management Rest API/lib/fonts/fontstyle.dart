import 'dart:math';

import 'package:flutter/material.dart';

var informationTextStyle = const TextStyle(fontFamily: 'Oxygen');
TextStyle detailTextStyle(
        Color color, FontWeight fontWeight, double fontSize) =>
    TextStyle(
      fontFamily: 'Oxygen',
      color: color,
      fontWeight: fontWeight,
      fontSize: fontSize,
    );
var randomColor = Color.fromRGBO(
  Random().nextInt(255),
  Random().nextInt(255),
  Random().nextInt(255),
  1,
);
