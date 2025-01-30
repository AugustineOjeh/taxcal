import 'dart:math';
import 'package:flutter/material.dart';
import 'package:taxcal/utils/image_urls.dart';

class TCDisplay {
  List<String> urls() {
    return TCImages.urls();
  }

  static double displayFontSize(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth > 768) {
      return 128;
    } else if (screenWidth > 480 && screenWidth <= 768) {
      return 64;
    } else {
      return 48;
    }
  }

  static String getImageUrl(List<String> urls) {
    final random = Random();
    return urls[random.nextInt(urls.length)];
  }
}
