import 'package:flutter/material.dart';
import 'package:taxcal/widgets/colors.dart';
import 'package:taxcal/widgets/texts.dart';

class TCField {
  static text({
    required BuildContext context,
    required String label,
    required String hint,
    required TextEditingController controller,
    ValueChanged<String>? onChanged,
    FormFieldValidator? validator,
    TextInputType? keyboardType,
    String? currency,
  }) {
    return Column(
        spacing: 10,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TCText.label(label, context),
          TextFormField(
              controller: controller,
              validator: validator,
              keyboardType: keyboardType,
              onChanged: onChanged,
              style: Theme.of(context).textTheme.bodySmall,
              decoration: InputDecoration(
                  isDense: true,
                  errorStyle: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(color: TCColor.red(context)),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 14, horizontal: 12),
                  prefixIcon: currency == null
                      ? null
                      : Padding(
                          padding: EdgeInsets.fromLTRB(12, 14, 4, 14),
                          child: TCText.input(currency, context)),
                  hintText: hint,
                  hintStyle: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(color: TCColor.border(context)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide:
                          BorderSide(color: TCColor.border(context), width: 1)),
                  errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide:
                          BorderSide(color: TCColor.red(context), width: 1)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                          color: TCColor.textBody(context), width: 1))))
        ]);
  }

  static dropdown({
    required BuildContext context,
    required String label,
    required String hint,
    required TextEditingController controller,
    required ValueChanged<dynamic> onChanged,
    required List<String> items,
    FormFieldValidator? validator,
    TextInputType? keyboardType,
  }) {
    return Column(
        spacing: 10,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TCText.label(label, context),
          DropdownButtonFormField(
              items: items.map((String item) {
                return DropdownMenuItem<String>(
                    value: item, child: TCText.input(item, context));
              }).toList(),
              validator: validator,
              onChanged: onChanged,
              style: Theme.of(context).textTheme.bodySmall,
              dropdownColor: TCColor.foreground(context),
              isExpanded: false,
              icon: Icon(Icons.expand_more_rounded),
              iconEnabledColor: TCColor.border(context),
              iconDisabledColor: TCColor.containerBg(context),
              decoration: InputDecoration(
                errorStyle: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: TCColor.red(context)),
                isDense: true,
                contentPadding:
                    EdgeInsets.symmetric(vertical: 14, horizontal: 12),
                hintText: hint,
                hintStyle: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: TCColor.border(context)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide:
                        BorderSide(color: TCColor.border(context), width: 1)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide:
                        BorderSide(color: TCColor.textBody(context), width: 1)),
                errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide:
                        BorderSide(color: TCColor.red(context), width: 1)),
              ))
        ]);
  }
}
