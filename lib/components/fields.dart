import 'package:flutter/material.dart';
import 'package:taxcal/styles/colors.dart';
import 'package:taxcal/styles/texts.dart';

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
                          padding: EdgeInsets.fromLTRB(12, 10, 4, 10),
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
    required ValueChanged<dynamic> onChanged,
    required List<String> items,
    required String? value,
    FormFieldValidator? validator,
    TextInputType? keyboardType,
  }) {
    return Column(
        spacing: 10,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TCText.label(label, context),
          DropdownButtonFormField(
              value: value,
              items: items.map((String item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: SizedBox(child: TCText.input(item, context)),
                );
              }).toList(),
              validator: validator,
              onChanged: onChanged,
              menuMaxHeight: 400,
              hint: TCText.placeholder(hint, context),
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(overflow: TextOverflow.ellipsis),
              dropdownColor: TCColor.foreground(context),
              isExpanded: false,
              icon: Icon(Icons.expand_more_rounded, size: 16),
              iconEnabledColor: TCColor.border(context),
              iconDisabledColor: TCColor.containerBg(context),
              decoration: InputDecoration(
                errorStyle: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: TCColor.red(context)),
                isDense: true,
                contentPadding:
                    EdgeInsets.symmetric(vertical: 12, horizontal: 12),
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
