import 'package:flutter/material.dart';

EdgeInsets dynamicPadding(BuildContext context) {
  double screenWidth = MediaQuery.of(context).size.width;
  if (screenWidth > 768) {
    return EdgeInsets.fromLTRB(72, 40, 32, 40);
  } else if (screenWidth > 480) {
    return EdgeInsets.symmetric(horizontal: 32, vertical: 48);
  } else {
    return EdgeInsets.symmetric(horizontal: 24, vertical: 48);
  }
}

double getMinContentHeight(BuildContext context) {
  double screenHeight = MediaQuery.of(context).size.height;
  return screenHeight - 160;
}
