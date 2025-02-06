import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taxcal/providers/expense_provider.dart';
import 'package:taxcal/providers/income_provider.dart';
import 'package:taxcal/providers/tax_provider.dart';
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
  num sumUpAmount(List<Map<String, dynamic>> entries) {
    num totalAmount =
        entries.fold(0, (sum, item) => sum + (item['amount'] as num));
    return totalAmount;
  }

  @override
  Widget build(BuildContext context) {
    final incomeEntries = ref.watch(incomeProvider);
    final expenseEntries = ref.watch(expenseProvider);
    final taxResult = ref.watch(taxProvider);
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
                entries: incomeEntries,
                removeEntry: (index) {
                  ref.read(incomeProvider.notifier).removeEntry(index);
                },
                amount: sumUpAmount(incomeEntries).toString(),
                isExpense: false,
                showBreakdown: _showIncomeBreakdown,
                onTap: () {
                  setState(() {
                    _showIncomeBreakdown = !_showIncomeBreakdown;
                  });
                }),
            TCContainer.income(context,
                currency: widget.currency,
                entries: expenseEntries,
                amount: sumUpAmount(expenseEntries).toString(),
                removeEntry: (index) {
                  ref.read(expenseProvider.notifier).removeEntry(index);
                },
                isExpense: true,
                showBreakdown: _showExpenseBreakdown,
                onTap: () {
                  setState(() {
                    _showExpenseBreakdown = !_showExpenseBreakdown;
                  });
                }),
            if (_calculationCompleted)
              TCContainer.tax(
                context,
                currency: widget.currency,
                showBreakdown: _showTaxBreakdown,
                result: taxResult,
                onTap: () {
                  setState(() {
                    _showTaxBreakdown = !_showTaxBreakdown;
                  });
                },
              ),
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
