import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taxcal/utils/categories.dart';
import 'package:taxcal/components/buttons.dart';
import 'package:taxcal/styles/colors.dart';
import 'package:taxcal/components/fields.dart';

class IncomeForm extends ConsumerStatefulWidget {
  final String currency;
  const IncomeForm({required this.currency, super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _IncomeFormState();
}

class _IncomeFormState extends ConsumerState<IncomeForm> {
  final _formKey = GlobalKey<FormState>();
  String? _category;
  final _amountController = TextEditingController();
  final _investedController = TextEditingController();
  final _descriptionController = TextEditingController();

  addNewIncome() {
    if (_formKey.currentState?.validate() ?? false) {
      return _category;
      // ADD FUNCTION HERE
    }
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 376),
        child: Form(
            key: _formKey,
            child: SizedBox(
                width: double.infinity,
                child: Column(spacing: 20, children: [
                  TCField.dropdown(
                      context: context,
                      label: 'Category',
                      hint: 'Salary/Employment Bonus',
                      onChanged: (value) {
                        setState(() {
                          _category = value;
                        });
                      },
                      validator: (value) {
                        if (value == null) {
                          return 'Choose category';
                        } else {
                          return null;
                        }
                      },
                      items: TCCategories.expense()),
                  Row(spacing: 32, children: [
                    Expanded(
                        child: TCField.text(
                            context: context,
                            controller: _investedController,
                            label: 'Amount Invested',
                            currency: widget.currency,
                            hint: '0.00',
                            validator: (value) {
                              if (value != null) {
                                final double? amount = double.tryParse(value);
                                if (amount == null) {
                                  return 'Enter valid amount';
                                } else {
                                  return null;
                                }
                              } else {
                                return null;
                              }
                            })),
                    Expanded(
                        child: TCField.text(
                            context: context,
                            controller: _amountController,
                            label: 'Amount Returned',
                            currency: widget.currency,
                            hint: '0.00',
                            validator: (value) {
                              if (value == null) {
                                return 'Field required';
                              } else {
                                final double? amount = double.tryParse(value);
                                if (amount == null) {
                                  return 'Enter valid amount';
                                } else {
                                  return null;
                                }
                              }
                            }))
                  ]),
                  TCField.text(
                      context: context,
                      label: 'Description',
                      hint: 'e.g. New employee referral bonus',
                      controller: _descriptionController),
                  Row(children: [
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.info_outline,
                        color: TCColor.border(context),
                      ),
                      iconSize: 32,
                    ),
                    Expanded(child: SizedBox()),
                    TCButton.secondary(context, 'Next', onPressed: addNewIncome)
                  ])
                ]))));
  }
}
