import 'package:flutter/material.dart';

EdgeInsets dynamicPadding(BuildContext context) {
  double screenWidth = MediaQuery.of(context).size.width;
  if (screenWidth > 768) {
    return EdgeInsets.fromLTRB(72, 24, 32, 8);
  } else if (screenWidth > 480) {
    return EdgeInsets.fromLTRB(32, 24, 32, 16);
  } else {
    return EdgeInsets.fromLTRB(24, 24, 24, 16);
  }
}

double getMinContentHeight(BuildContext context) {
  double screenHeight = MediaQuery.of(context).size.height;
  return screenHeight - 160;
}
