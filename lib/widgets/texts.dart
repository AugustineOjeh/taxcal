import 'package:flutter/material.dart';

class TCText {
  static title(String text, BuildContext context,
      {bool bold = true, bool italic = false}) {
    return Text(text,
        textAlign: TextAlign.left,
        softWrap: true,
        style: Theme.of(context).textTheme.displayLarge!.copyWith(
            fontStyle: italic ? FontStyle.italic : null,
            fontWeight: bold ? FontWeight.w700 : FontWeight.normal));
  }

  static label(String text, BuildContext context) {
    return Text(text,
        textAlign: TextAlign.left,
        softWrap: true,
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: Theme.of(context).colorScheme.secondary,
            fontWeight: FontWeight.w500));
  }

  static headingSmall(String text, BuildContext context) {
    return Text(text,
        textAlign: TextAlign.left,
        softWrap: true,
        style: Theme.of(context).textTheme.bodyMedium);
  }

  static description(String text, BuildContext context) {
    return Text(text,
        textAlign: TextAlign.left,
        softWrap: true,
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
