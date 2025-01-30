import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taxcal/widgets/buttons.dart';
import 'package:taxcal/widgets/colors.dart';
import 'package:taxcal/widgets/containers.dart';
import 'package:taxcal/widgets/form_holder.dart';

class CalculatorDesktop extends ConsumerStatefulWidget {
  final String currency;
  const CalculatorDesktop({required this.currency, super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CalculatorDesktopState();
}

class _CalculatorDesktopState extends ConsumerState<CalculatorDesktop> {
  bool _showTaxBreakdown = false;
  bool _showExpenseBreakdown = false;
  bool _showIncomeBreakdown = false;
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
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
                          TCContainer.income(
                            context,
                            currency: widget.currency,
                            amount: '30,000',
                            isExpense: false,
                            onTap: () {
                              setState(() {
                                _showIncomeBreakdown = !_showIncomeBreakdown;
                              });
                            },
                          ),
                          TCContainer.income(
                            context,
                            currency: widget.currency,
                            amount: '600,000',
                            isExpense: true,
                            onTap: () {
                              setState(() {
                                _showExpenseBreakdown = !_showExpenseBreakdown;
                              });
                            },
                          ),
                          TCContainer.tax(
                            context,
                            currency: widget.currency,
                            amount: '53,450',
                            onTap: () {
                              setState(() {
                                _showTaxBreakdown = !_showTaxBreakdown;
                              });
                            },
                          ),
                        ]),
                        SizedBox(
                          height: 8,
                        ),
                        FormHolder(currency: widget.currency),
                        TCButton.primary(context, 'Calculate tax',
                            onPressed: () {})
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
