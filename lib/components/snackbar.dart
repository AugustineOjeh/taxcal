import 'package:flutter/material.dart';
import 'package:taxcal/styles/colors.dart';
import 'package:taxcal/styles/texts.dart';

class TCSnackbar {
  static primary(BuildContext context, String message,
      {required bool isError}) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: TCText.description(message, context,
            color: TCColor.foreground(context)),
        elevation: 1,
        duration: Duration(seconds: 3),
        backgroundColor:
            isError ? TCColor.red(context) : TCColor.green(context),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
            side: BorderSide(width: 1, color: TCColor.foreground(context))),
        behavior: SnackBarBehavior.floating,
        width: 300,
      ),
    );
  }
}
