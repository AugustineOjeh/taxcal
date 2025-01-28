import 'package:flutter/material.dart';

double displayFontSize(BuildContext context) {
  double screenWidth = MediaQuery.of(context).size.width;
  if (screenWidth > 768) {
    return 128;
  } else if (screenWidth > 480) {
    return 96;
  } else {
    return 64;
  }
}
