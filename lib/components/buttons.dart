import 'package:flutter/material.dart';
import 'package:taxcal/styles/colors.dart';
import 'package:taxcal/styles/texts.dart';

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

  static secondary(BuildContext context, String label,
      {required void Function() onPressed}) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          padding: WidgetStatePropertyAll(
              EdgeInsets.symmetric(vertical: 16, horizontal: 16)),
          elevation: WidgetStatePropertyAll(0),
          backgroundColor: WidgetStatePropertyAll(TCColor.secondary(context)),
          shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(40))),
        ),
        child:
            TCText.label(label, context, color: TCColor.foreground(context)));
  }

  static toggle(BuildContext context, String label,
      {required void Function() onPressed, required bool isSelected}) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          padding: WidgetStatePropertyAll(
              EdgeInsets.symmetric(vertical: 16, horizontal: 16)),
          elevation: WidgetStatePropertyAll(0),
          backgroundColor: WidgetStatePropertyAll(isSelected
              ? TCColor.secondary(context)
              : TCColor.foreground(context)),
          shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
        ),
        child: Center(
          child: TCText.description(label, context,
              color: isSelected
                  ? TCColor.foreground(context)
                  : TCColor.secondary(context)),
        ));
  }
}
