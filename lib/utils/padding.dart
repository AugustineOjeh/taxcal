import 'package:flutter/material.dart';

EdgeInsets dynamicPadding(BuildContext context) {
  double screenWidth = MediaQuery.of(context).size.width;
  if (screenWidth > 768) {
    return EdgeInsets.fromLTRB(72, 72, 0, 72);
  } else if (screenWidth > 480) {
    return EdgeInsets.all(40);
  } else {
    return EdgeInsets.all(20);
  }
}
