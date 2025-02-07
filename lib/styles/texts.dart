import 'package:flutter/material.dart';

class TCText {
  static title(String text, BuildContext context, {bool italic = false}) {
    return Text(text,
        textAlign: TextAlign.left,
        softWrap: true,
        overflow: TextOverflow.clip,
        style: Theme.of(context).textTheme.displayLarge!.copyWith(
            fontStyle: italic ? FontStyle.italic : null,
            height: 0.8,
            fontWeight: FontWeight.normal));
  }

  static label(String text, BuildContext context, {Color? color}) {
    return Text(text,
        textAlign: TextAlign.left,
        softWrap: true,
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: color ?? Theme.of(context).colorScheme.secondary,
            fontWeight: FontWeight.w500));
  }

  static headingSmall(String text, BuildContext context,
      {Color? color, bool isBold = true}) {
    return Text(text,
        textAlign: TextAlign.left,
        softWrap: true,
        style: Theme.of(context)
            .textTheme
            .bodyLarge!
            .copyWith(color: color, fontWeight: FontWeight.w600));
  }

  static description(String text, BuildContext context,
      {Color? color, bool? isBold, bool? truncate}) {
    return Text(text,
        textAlign: TextAlign.left,
        overflow: truncate == true ? TextOverflow.ellipsis : null,
        softWrap: true,
        style: Theme.of(context).textTheme.labelSmall!.copyWith(
            color: color, fontWeight: isBold == true ? FontWeight.bold : null));
  }

  static input(String text, BuildContext context) {
    return Text(text,
        textAlign: TextAlign.left,
        softWrap: true,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context).textTheme.bodySmall);
  }

  static placeholder(String text, BuildContext context) {
    return Text(text,
        textAlign: TextAlign.left,
        softWrap: true,
        style: Theme.of(context)
            .textTheme
            .bodySmall!
            .copyWith(color: Theme.of(context).colorScheme.secondaryContainer));
  }
}
