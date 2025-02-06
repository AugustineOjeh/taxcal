import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taxcal/providers/expense_provider.dart';
import 'package:taxcal/providers/income_provider.dart';
import 'package:taxcal/providers/tax_provider.dart';
import 'package:taxcal/widgets/buttons.dart';
import 'package:taxcal/widgets/colors.dart';
import 'package:taxcal/widgets/containers.dart';
import 'package:taxcal/widgets/form_holder.dart';
import 'package:taxcal/widgets/snackbar.dart';

class CalculatorDesktop extends ConsumerStatefulWidget {
  final String currency;
  const CalculatorDesktop({required this.currency, super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CalculatorDesktopState();
}

class _CalculatorDesktopState extends ConsumerState<CalculatorDesktop> {
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
    double screenHeight = MediaQuery.of(context).size.height;
    final incomeEntries = ref.watch(incomeProvider);
    final expenseEntries = ref.watch(expenseProvider);
    final taxResult = ref.watch(taxProvider);
    return Row(
        spacing: 32,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                  maxHeight: screenHeight - 184, maxWidth: 450, minWidth: 300),
              child: Container(
                height: screenHeight - 184,
                padding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
                decoration: BoxDecoration(
                    color: TCColor.containerBg(context),
                    borderRadius: BorderRadius.circular(18)),
                child: ScrollConfiguration(
                  behavior: ScrollBehavior().copyWith(scrollbars: false),
                  child: SingleChildScrollView(
                    child: Column(
                      spacing: 24,
                      children: [
                        Column(spacing: 10, children: [
                          TCContainer.income(context,
                              currency: widget.currency,
                              entries: incomeEntries,
                              removeEntry: (index) {
                                ref
                                    .read(incomeProvider.notifier)
                                    .removeEntry(index);
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
                                ref
                                    .read(expenseProvider.notifier)
                                    .removeEntry(index);
                              },
                              isExpense: true,
                              showBreakdown: _showExpenseBreakdown,
                              onTap: () {
                                setState(() {
                                  _showExpenseBreakdown =
                                      !_showExpenseBreakdown;
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
                        ]),
                        SizedBox(height: 8),
                        FormHolder(currency: widget.currency),
                        TCButton.primary(
                            context,
                            _calculationCompleted
                                ? 'Re-calculate tax'
                                : 'Calculate tax', onPressed: () {
                          if (expenseEntries.isEmpty || incomeEntries.isEmpty) {
                            TCSnackbar.primary(context,
                                'Need expenses and incomes to calculate tax',
                                isError: true);
                          } else {
                            ref.read(taxProvider.notifier).calculateTax(
                                incomeEntries: incomeEntries,
                                expenseEntries: expenseEntries);
                            setState(() {
                              _calculationCompleted = true;
                            });
                          }
                        })
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: SizedBox(
                width: double.infinity,
                height: screenHeight - 184,
                child: TCContainer.pageTitle(context)),
          )
        ]);
  }
}
