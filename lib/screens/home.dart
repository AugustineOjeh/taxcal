import 'package:flutter/material.dart';
import 'package:taxcal/components/buttons.dart';
import 'package:taxcal/components/form_holder.dart';
import 'package:taxcal/logics/tax_logics_nigeria.dart';
import 'package:taxcal/styles/texts.dart';
import 'package:taxcal/utils/dimensions.dart';
import 'package:taxcal/styles/colors.dart';
import 'package:taxcal/utils/utilities.dart';
import 'package:taxcal/widgets/appbar.dart';
import 'package:taxcal/widgets/containers.dart';

class Home extends StatefulWidget {
  const Home({required this.version, required this.sdkVersion, super.key});
  final String version;
  final String sdkVersion;

  @override
  State<StatefulWidget> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String country = 'Nigeria';
  String currency = '₦';
  List<Map<String, dynamic>> expenseEntries = [];
  List<Map<String, dynamic>> incomeEntries = [];
  Map<String, double> taxBreakdown = {};
  final _incomeFormKey = GlobalKey<FormState>();
  final _expenseFormKey = GlobalKey<FormState>();
  double _totalIncome = 0;
  double _totalExpenses = 0;
  bool _showIncomeBreakdown = false;
  bool _showExpenseBreakdown = false;
  bool _showTaxBreakdown = false;
  bool _calculationCompleted = false;
  bool _focusOnExpense = false;
  bool _errorOccured = false;
  String? expenseCategory;
  String? incomeCategory;
  final expenseDescriptionController = TextEditingController();
  final incomeDescriptionController = TextEditingController();
  final incomeAmountController = TextEditingController();
  final investedAmountController = TextEditingController();
  final expenseAmountController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
  }

  void addNewIncome() {
    if (_incomeFormKey.currentState!.validate()) {
      final Map<String, dynamic> newEntry = {
        'category': incomeCategory,
        'description': incomeDescriptionController.text,
        'amount': double.parse(incomeAmountController.text),
        'isTaxable': NigeriaTaxLogics().isTaxable(incomeCategory!),
      };
      if (investedAmountController.text.isNotEmpty) {
        newEntry['isCapitalGain'] = true;
        newEntry['investedAmount'] =
            double.tryParse(investedAmountController.text);
      } else {
        newEntry['isCapitalGain'] = false;
      }
      incomeEntries.add(newEntry);
      clearInputs();
      sumValue();
    }
  }

  void addNewExpense() {
    if (_expenseFormKey.currentState!.validate()) {
      final Map<String, dynamic> newEntry = {
        'category': expenseCategory,
        'description': expenseDescriptionController.text,
        'amount': double.parse(expenseAmountController.text),
        'isDeductible': NigeriaTaxLogics().isDeductible(expenseCategory!),
      };
      expenseEntries.add(newEntry);
      clearInputs();
      sumValue();
    }
  }

  void calculateTax() {
    final double deductions = NigeriaTaxLogics().sumDeductions(expenseEntries);
    final grossIncome = NigeriaTaxLogics().sumIncome(incomeEntries);
    final double reliefAllowance = NigeriaTaxLogics()
        .calculateReliefAllowance(grossIncome, expenseEntries);
    final double nonTaxableIncome =
        NigeriaTaxLogics().sumNonTaxableIncome(incomeEntries);
    final double investmentReturns =
        NigeriaTaxLogics().sumInvestmentReturns(incomeEntries);
    final double capitalGains =
        NigeriaTaxLogics().sumCapitalGains(incomeEntries);
    final double taxableIncome = grossIncome -
        (nonTaxableIncome + investmentReturns + deductions + reliefAllowance);
    final capitalGainsTax =
        NigeriaTaxLogics().calculateCapitalGainsTax(capitalGains);
    final incomeTax =
        NigeriaTaxLogics().calculateIncomeTax(taxableIncome, grossIncome);
    final Map<String, double> taxData = {
      'taxableIncome': taxableIncome < 0 ? 0 : taxableIncome,
      'capitalGains': capitalGains,
      'capitalGainsTax': capitalGainsTax,
      'deductions': deductions,
      'reliefAllowance': reliefAllowance,
      'incomeTax': incomeTax
    };
    setState(() {
      taxBreakdown = taxData;
    });
  }

  void clearInputs() {
    expenseDescriptionController.clear();
    incomeDescriptionController.clear();
    incomeAmountController.clear();
    investedAmountController.clear();
    expenseAmountController.clear();
    setState(() {
      expenseCategory = null;
      incomeCategory = null;
    });
  }

  void sumValue() {
    final double sumExpenses = expenseEntries.fold(
        0, (sum, expense) => sum + (expense['amount'] as double));
    final double sumIncome = incomeEntries.fold(
        0, (sum, income) => sum + ((income['amount']) as double));
    setState(() {
      _totalExpenses = sumExpenses;
      _totalIncome = sumIncome;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        body: SizedBox(
            height: screenHeight,
            child: Center(
                child: ConstrainedBox(
                    constraints:
                        BoxConstraints(maxWidth: 1500, maxHeight: screenHeight),
                    child: Padding(
                        padding: dynamicPadding(context),
                        child: ScrollConfiguration(
                          behavior:
                              ScrollBehavior().copyWith(scrollbars: false),
                          child: SingleChildScrollView(
                            child: SizedBox(
                                width: double.infinity,
                                child: GestureDetector(
                                    onTap: () {
                                      FocusScope.of(context).unfocus();
                                    },
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          TCAppBar().primary(
                                              context: context,
                                              version: widget.version,
                                              selectedCountry: country),
                                          SizedBox(height: 56),
                                          SizedBox(
                                              width: double.infinity,
                                              child: Column(
                                                spacing: 24,
                                                children: [
                                                  if (screenWidth < 900)
                                                    ConstrainedBox(
                                                        constraints:
                                                            BoxConstraints(
                                                                maxHeight: 358),
                                                        child: TCContainer
                                                            .pageTitle(
                                                                context)),
                                                  Row(
                                                      spacing: 32,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Flexible(
                                                            child:
                                                                ConstrainedBox(
                                                                    constraints: BoxConstraints(
                                                                        maxHeight:
                                                                            screenHeight -
                                                                                200,
                                                                        maxWidth:
                                                                            450,
                                                                        minWidth:
                                                                            300),
                                                                    child: Container(
                                                                        height: screenHeight - 184,
                                                                        padding: EdgeInsets.all(16),
                                                                        decoration: BoxDecoration(color: TCColor.containerBg(context), borderRadius: BorderRadius.circular(18)),
                                                                        child: ScrollConfiguration(
                                                                            behavior: ScrollBehavior().copyWith(scrollbars: false),
                                                                            child: SingleChildScrollView(
                                                                                child: Column(spacing: 24, children: [
                                                                              Column(spacing: 10, children: [
                                                                                TCContainer.income(
                                                                                  context,
                                                                                  amount: TCUtils().formatAmount(_totalIncome),
                                                                                  entries: incomeEntries,
                                                                                  currency: currency,
                                                                                  isExpense: false,
                                                                                  removeEntry: (index) {
                                                                                    setState(() {
                                                                                      incomeEntries.removeAt(index);
                                                                                    });
                                                                                    sumValue();
                                                                                  },
                                                                                  showBreakdown: _showIncomeBreakdown,
                                                                                  onTap: () {
                                                                                    setState(() {
                                                                                      _showIncomeBreakdown = !_showIncomeBreakdown;
                                                                                    });
                                                                                  },
                                                                                ),
                                                                                TCContainer.income(
                                                                                  context,
                                                                                  amount: TCUtils().formatAmount(_totalExpenses),
                                                                                  entries: expenseEntries,
                                                                                  currency: currency,
                                                                                  isExpense: true,
                                                                                  removeEntry: (index) {
                                                                                    setState(() {
                                                                                      expenseEntries.removeAt(index);
                                                                                    });
                                                                                    sumValue();
                                                                                  },
                                                                                  showBreakdown: _showExpenseBreakdown,
                                                                                  onTap: () {
                                                                                    setState(() {
                                                                                      _showExpenseBreakdown = !_showExpenseBreakdown;
                                                                                    });
                                                                                  },
                                                                                ),
                                                                                if (_calculationCompleted)
                                                                                  TCContainer.tax(
                                                                                    context,
                                                                                    currency: currency,
                                                                                    showBreakdown: _showTaxBreakdown,
                                                                                    result: taxBreakdown,
                                                                                    onTap: () {
                                                                                      setState(() {
                                                                                        _showTaxBreakdown = !_showTaxBreakdown;
                                                                                      });
                                                                                    },
                                                                                  ),
                                                                              ]),
                                                                              SizedBox(height: 8),
                                                                              FormHolder().inputForm(
                                                                                context,
                                                                                currency: currency,
                                                                                switchFocus: () {
                                                                                  setState(() {
                                                                                    _focusOnExpense = !_focusOnExpense;
                                                                                  });
                                                                                },
                                                                                incomeCategoryValidation: (value) {
                                                                                  if (value == null) {
                                                                                    return 'Choose category';
                                                                                  } else {
                                                                                    return null;
                                                                                  }
                                                                                },
                                                                                investedAmountValidation: (value) {
                                                                                  if (value != null && value.isNotEmpty) {
                                                                                    final double? amount = double.tryParse(value);
                                                                                    if (amount == null) {
                                                                                      return 'Enter valid amount';
                                                                                    } else {
                                                                                      return null;
                                                                                    }
                                                                                  } else {
                                                                                    return null;
                                                                                  }
                                                                                },
                                                                                incomeAmountValidation: (value) {
                                                                                  final double? amount = double.tryParse(value);
                                                                                  if (amount == null) {
                                                                                    return 'Enter valid amount';
                                                                                  } else {
                                                                                    return null;
                                                                                  }
                                                                                },
                                                                                expenseAmountValidation: (value) {
                                                                                  final double? amount = double.tryParse(value);
                                                                                  if (amount == null) {
                                                                                    return 'Enter valid amount';
                                                                                  } else {
                                                                                    return null;
                                                                                  }
                                                                                },
                                                                                expenseCategoryValidation: (value) {
                                                                                  if (value == null) {
                                                                                    return 'Choose category';
                                                                                  } else {
                                                                                    return null;
                                                                                  }
                                                                                },
                                                                                focusedOnExpense: _focusOnExpense,
                                                                                incomeCategory: incomeCategory,
                                                                                expenseCategory: expenseCategory,
                                                                                onIncomeCategoryChange: (value) {
                                                                                  setState(() {
                                                                                    incomeCategory = value;
                                                                                  });
                                                                                },
                                                                                onExpenseCategoryChange: (value) {
                                                                                  setState(() {
                                                                                    expenseCategory = value;
                                                                                  });
                                                                                },
                                                                                onIncomeSubmit: addNewIncome,
                                                                                onExpenseSubmit: addNewExpense,
                                                                                incomeAmountController: incomeAmountController,
                                                                                incomeDescriptionController: incomeDescriptionController,
                                                                                investedAmountController: investedAmountController,
                                                                                expenseAmountController: expenseAmountController,
                                                                                expenseDescriptionController: expenseDescriptionController,
                                                                                incomeFormKey: _incomeFormKey,
                                                                                expenseFormKey: _expenseFormKey,
                                                                              ),
                                                                              if (_errorOccured)
                                                                                TCText.description('Please, provide income data', context, isBold: true, color: TCColor.red(context)),
                                                                              TCButton.primary(context, _calculationCompleted ? 'Re-calculate tax' : 'Calculate tax', onPressed: () async {
                                                                                setState(() {
                                                                                  _calculationCompleted = false;
                                                                                });
                                                                                if (incomeEntries.isEmpty) {
                                                                                  setState(() {
                                                                                    _errorOccured = true;
                                                                                  });
                                                                                  await Future.delayed(Duration(seconds: 5));
                                                                                  setState(() {
                                                                                    _errorOccured = false;
                                                                                  });
                                                                                } else {
                                                                                  calculateTax();
                                                                                  setState(() {
                                                                                    _calculationCompleted = true;
                                                                                  });
                                                                                }
                                                                              })
                                                                            ])))))),
                                                        // THIS IS THE BIG IMAGE CONTAINER ON THE RIGHT OF THE DESKTOP INTERFACE
                                                        if (screenWidth >= 900)
                                                          Expanded(
                                                            flex: 2,
                                                            child: SizedBox(
                                                                width: double
                                                                    .infinity,
                                                                height:
                                                                    screenHeight -
                                                                        200,
                                                                child: TCContainer
                                                                    .pageTitle(
                                                                        context)),
                                                          )
                                                      ]),
                                                  Center(
                                                      child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      TCText.input(
                                                          '© 2025 Augustine Ojeh –written in ',
                                                          context,
                                                          // isBold: true,
                                                          color: TCColor.border(
                                                              context)),
                                                      TCText.input(
                                                          'Dart ${widget.sdkVersion}',
                                                          context,
                                                          isBold: true,
                                                          color: TCColor.border(
                                                              context)),
                                                    ],
                                                  ))
                                                ],
                                              )),
                                        ]))),
                          ),
                        ))))));
  }
}
