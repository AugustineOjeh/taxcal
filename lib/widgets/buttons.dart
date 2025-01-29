import 'package:flutter/material.dart';
import 'package:taxcal/widgets/colors.dart';
import 'package:taxcal/widgets/texts.dart';

class TCButton {
  static primary(BuildContext context, String label,
      {required void Function() onPressed}) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          padding: WidgetStatePropertyAll(EdgeInsets.symmetric(vertical: 16)),
          elevation: WidgetStatePropertyAll(0),
          backgroundColor: WidgetStatePropertyAll(TCColor.primary(context)),
          shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
        ),
        child: Center(
          child:
              TCText.label(label, context, color: TCColor.foreground(context)),
        ));
  }
}
