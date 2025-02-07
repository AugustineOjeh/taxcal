import 'package:flutter/material.dart';
import 'package:taxcal/utils/categories.dart';
import 'package:taxcal/components/buttons.dart';
import 'package:taxcal/styles/colors.dart';
import 'package:taxcal/components/fields.dart';

class TCForms {
  Widget income(BuildContext context,
      {required TextEditingController investAmountController,
      required TextEditingController amountController,
      required TextEditingController descriptionController,
      required String? category,
      required ValueChanged onDropdownChange,
      required FormFieldValidator dropdownValidation,
      required FormFieldValidator investedAmountValidation,
      required FormFieldValidator amountValidation,
      required String currency,
      required Key formKey,
      required void Function() onIncomeSubmit}) {
    return ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 376),
        child: Form(
            key: formKey,
            child: SizedBox(
                width: double.infinity,
                child: Column(spacing: 20, children: [
                  TCField.dropdown(
                      context: context,
                      value: category,
                      label: 'Category',
                      hint: 'Salary/Employment Bonus',
                      onChanged: onDropdownChange,
                      validator: dropdownValidation,
                      items: TCCategories.income()),
                  Row(spacing: 32, children: [
                    if (category == 'ROI (Domestic Invesment)' ||
                        category == 'ROI (Foreign Invesment)')
                      Expanded(
                          child: TCField.text(
                              context: context,
                              controller: investAmountController,
                              label: 'Invested',
                              currency: currency,
                              hint: '0.00',
                              validator: investedAmountValidation)),
                    Expanded(
                        child: TCField.text(
                            context: context,
                            controller: amountController,
                            label: 'Earned',
                            currency: currency,
                            hint: '0.00',
                            validator: amountValidation))
                  ]),
                  TCField.text(
                      context: context,
                      label: 'Description',
                      hint: 'e.g. New employee referral bonus',
                      controller: descriptionController),
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
                    TCButton.secondary(context, 'Next',
                        onPressed: onIncomeSubmit)
                  ])
                ]))));
  }

  Widget expense(BuildContext context,
      {required TextEditingController amountController,
      required TextEditingController descriptionController,
      required String? category,
      required ValueChanged onDropdownChange,
      required FormFieldValidator dropdownValidation,
      required FormFieldValidator amountValidation,
      required String currency,
      required Key formKey,
      required void Function() onExpenseSubmit}) {
    return ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 376),
        child: Form(
            key: formKey,
            child: SizedBox(
                width: double.infinity,
                child: Column(spacing: 20, children: [
                  TCField.dropdown(
                      context: context,
                      value: category,
                      label: 'Category',
                      hint: 'Food & Catering',
                      onChanged: onDropdownChange,
                      validator: dropdownValidation,
                      items: TCCategories.expense()),
                  Row(spacing: 32, children: [
                    Expanded(
                        child: TCField.text(
                      context: context,
                      controller: amountController,
                      label: 'Amount',
                      currency: currency,
                      hint: '0.00',
                      validator: amountValidation,
                    ))
                  ]),
                  TCField.text(
                      context: context,
                      label: 'Description',
                      hint: 'e.g. Loan interest payment',
                      controller: descriptionController),
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
                    TCButton.secondary(context, 'Next',
                        onPressed: onExpenseSubmit)
                  ])
                ]))));
  }
}
