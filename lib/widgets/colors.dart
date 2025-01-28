import 'package:flutter/material.dart';

class TCColor {
  static Color primary(BuildContext context) {
    return Theme.of(context).colorScheme.primary;
  }

  static Color secondary(BuildContext context) {
    return Theme.of(context).colorScheme.secondary;
  }

  static Color border(BuildContext context) {
    return Theme.of(context).colorScheme.secondaryContainer;
  }

  static Color forground(BuildContext context) {
    return Theme.of(context).colorScheme.onPrimary;
  }

  static Color containerBg(BuildContext context) {
    return Theme.of(context).colorScheme.surface.withValues(alpha: 0.6);
  }

  static Color green(BuildContext context) {
    return Color(0xFF34C759);
  }

  static Color red(BuildContext context) {
    return Color(0xFF34C759);
  }
}
