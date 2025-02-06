import 'package:flutter/material.dart';
import 'package:taxcal/widgets/colors.dart';
import 'package:taxcal/widgets/texts.dart';

class TCSnackbar {
  static primary(BuildContext context, String message,
      {required bool isError}) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: TCText.description(message, context,
              color: TCColor.foreground(context)),
          duration: Duration(seconds: 3), // Show for 3 seconds
          backgroundColor:
              isError ? TCColor.red(context) : TCColor.green(context),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(24)),
    );
  }
}
