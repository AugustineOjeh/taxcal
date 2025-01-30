import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taxcal/utils/categories.dart';
import 'package:taxcal/widgets/buttons.dart';
import 'package:taxcal/widgets/colors.dart';
import 'package:taxcal/widgets/fields.dart';

class ExpenseForm extends ConsumerStatefulWidget {
  final String currency;
  const ExpenseForm({required this.currency, super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ExpenseFormState();
}

class _ExpenseFormState extends ConsumerState<ExpenseForm> {
  final _formKey = GlobalKey<FormState>();
  String? _category;
  final _amountController = TextEditingController();
  final _descriptionController = TextEditingController();

  void addNewExpense() {
    if (_formKey.currentState?.validate() ?? false) {
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
                  hint: 'Food & Catering',
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
              TCField.text(
                  context: context,
                  controller: _amountController,
                  label: 'Amount',
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
                  }),
              TCField.text(
                  context: context,
                  label: 'Description',
                  hint: 'e.g. Loan interest payment',
                  controller: _descriptionController),
              Row(
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.info_outline,
                        color: TCColor.border(context),
                      ),
                      iconSize: 32),
                  Expanded(child: SizedBox()),
                  TCButton.secondary(context, 'Next', onPressed: addNewExpense)
                ],
              ),
            ]),
          ),
        ));
  }
}
