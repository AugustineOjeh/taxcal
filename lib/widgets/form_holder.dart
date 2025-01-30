import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taxcal/widgets/buttons.dart';
import 'package:taxcal/widgets/colors.dart';
import 'package:taxcal/widgets/expense_form.dart';
import 'package:taxcal/widgets/income_form.dart';

class FormHolder extends ConsumerStatefulWidget {
  final String currency;
  const FormHolder({required this.currency, super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FormHolderState();
}

class _FormHolderState extends ConsumerState<FormHolder> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
            border: Border.all(width: 1, color: TCColor.border(context)),
            borderRadius: BorderRadius.circular(18)),
        child: Column(spacing: 24, children: [
          Container(
              width: double.infinity,
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: TCColor.textBody(context, opacity: 0.1)),
              child: Row(spacing: 4, children: [
                Expanded(
                    child: TCButton.toggle(context, 'Earnings', onPressed: () {
                  if (_currentIndex != 0) {
                    setState(() {
                      _currentIndex = 0;
                    });
                  }
                }, isSelected: _currentIndex == 0)),
                Expanded(
                    child: TCButton.toggle(context, 'Spendings', onPressed: () {
                  if (_currentIndex != 1) {
                    setState(() {
                      _currentIndex = 1;
                    });
                  }
                }, isSelected: _currentIndex == 1)),
              ])),
          _currentIndex == 0
              ? IncomeForm(currency: widget.currency)
              : ExpenseForm(currency: widget.currency)
        ]));
  }
}
