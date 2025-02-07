import 'package:flutter/material.dart';
import 'package:taxcal/styles/colors.dart';

Widget getCountry(
  BuildContext context, {
  List<Map<String, String>> countryList = countries,
  void Function()? onTap,
  required String selectedCountry,
}) {
  return Row(
    spacing: 4,
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              image: DecorationImage(
                  image: AssetImage('lib/assets/images/nigeria_flag.png'),
                  fit: BoxFit.fill))),
      Icon(
        Icons.expand_more_outlined,
        size: 20,
        color: TCColor.border(context),
      )
    ],
  );
}

const List<Map<String, String>> countries = [
  {
    'name': 'Nigeria',
    'flag': 'lib/assets/images/nigeria_flag.png',
    'currency': '₦'
  }
];
