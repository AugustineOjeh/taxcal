import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taxcal/widgets/buttons.dart';
import 'package:taxcal/widgets/colors.dart';
import 'package:taxcal/widgets/containers.dart';
import 'package:taxcal/widgets/form_holder.dart';

class CalculatorMobile extends ConsumerStatefulWidget {
  final String currency;
  const CalculatorMobile({required this.currency, super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CalculatorMobileState();
}

class _CalculatorMobileState extends ConsumerState<CalculatorMobile> {
  bool _calculationCompleted = false;
  bool _showTaxBreakdown = false;
  bool _showExpenseBreakdown = false;
  bool _showIncomeBreakdown = false;
  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: ScrollBehavior().copyWith(scrollbars: false),
      child: SingleChildScrollView(
          child: Column(spacing: 24, children: [
        ConstrainedBox(
            constraints: BoxConstraints(maxHeight: 358),
            child: TCContainer.pageTitle(context)),
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
          decoration: BoxDecoration(
              color: TCColor.containerBg(context),
              borderRadius: BorderRadius.circular(18)),
          child: Column(spacing: 10, children: [
            TCContainer.income(context,
                currency: widget.currency,
                amount: '600,000',
                isExpense: false, onTap: () {
              setState(() {
                _showIncomeBreakdown = !_showIncomeBreakdown;
              });
            }),
            TCContainer.income(context,
                currency: widget.currency,
                amount: '30,000',
                isExpense: true, onTap: () {
              setState(() {
                _showExpenseBreakdown = !_showExpenseBreakdown;
              });
            }),
            TCContainer.tax(context,
                amount: '53,450', currency: widget.currency, onTap: () {
              setState(() {
                _showTaxBreakdown = !_showTaxBreakdown;
              });
            }),
            SizedBox(height: 24),
            FormHolder(currency: widget.currency),
            SizedBox(height: 16),
            TCButton.primary(context,
                _calculationCompleted ? 'Re-calculate tax' : 'Calculate tax',
                onPressed: () {})
          ]),
        ),
      ])),
    );
  }
}
