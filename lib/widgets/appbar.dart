import 'package:flutter/material.dart';
import 'package:taxcal/styles/colors.dart';
import 'package:taxcal/styles/texts.dart';
import 'package:taxcal/widgets/country_switch.dart';

class TCAppBar {
  Widget primary({
    required BuildContext context,
    required String version,
    required String selectedCountry,
  }) {
    return AppBar(
        forceMaterialTransparency: true,
        title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                  spacing: 10,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Image.asset(
                      'lib/assets/images/logo_light.png',
                      height: 24,
                      fit: BoxFit.contain,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                              width: 1, color: TCColor.border(context))),
                      child: TCText.description(version, context, isBold: true),
                    )
                  ]),
              Padding(
                  padding: EdgeInsets.only(left: 8, top: 4),
                  child: TCText.description('An Ojehs\' Project', context))
            ]),
        actions: [getCountry(context, selectedCountry: selectedCountry)]);
  }
}
