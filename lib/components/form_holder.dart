import 'package:flutter/material.dart';
import 'package:taxcal/components/buttons.dart';
import 'package:taxcal/styles/colors.dart';
import 'package:taxcal/widgets/forms.dart';

class FormHolder {
  Widget inputForm(
    BuildContext context, {
    required bool focusedOnExpense,
    required void Function() switchFocus,
    required void Function() onIncomeSubmit,
    required void Function() onExpenseSubmit,
    required TextEditingController investedAmountController,
    required TextEditingController incomeAmountController,
    required TextEditingController expenseAmountController,
    required TextEditingController incomeDescriptionController,
    required TextEditingController expenseDescriptionController,
    required FormFieldValidator investedAmountValidation,
    required FormFieldValidator incomeAmountValidation,
    required FormFieldValidator expenseAmountValidation,
    required FormFieldValidator incomeCategoryValidation,
    required FormFieldValidator expenseCategoryValidation,
    required String? incomeCategory,
    required String? expenseCategory,
    required ValueChanged onIncomeCategoryChange,
    required ValueChanged onExpenseCategoryChange,
    required String currency,
    required Key incomeFormKey,
    required Key expenseFormKey,
  }) {
    return Container(
        padding: EdgeInsets.all(16),
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
                    child: TCButton.toggle(context, 'Earnings',
                        onPressed: focusedOnExpense ? switchFocus : () {},
                        isSelected: !focusedOnExpense)),
                Expanded(
                    child: TCButton.toggle(context, 'Spendings',
                        onPressed: focusedOnExpense ? () {} : switchFocus,
                        isSelected: focusedOnExpense)),
              ])),
          focusedOnExpense
              ? TCForms().expense(context,
                  amountController: expenseAmountController,
                  descriptionController: expenseDescriptionController,
                  category: expenseCategory,
                  onDropdownChange: onExpenseCategoryChange,
                  currency: currency,
                  formKey: expenseFormKey,
                  amountValidation: expenseAmountValidation,
                  dropdownValidation: expenseCategoryValidation,
                  onExpenseSubmit: onExpenseSubmit)
              : TCForms().income(context,
                  investAmountController: investedAmountController,
                  amountController: incomeAmountController,
                  descriptionController: incomeDescriptionController,
                  category: incomeCategory,
                  amountValidation: incomeAmountValidation,
                  dropdownValidation: incomeCategoryValidation,
                  investedAmountValidation: investedAmountValidation,
                  onDropdownChange: onIncomeCategoryChange,
                  currency: currency,
                  formKey: incomeFormKey,
                  onIncomeSubmit: onIncomeSubmit)
        ]));
  }
}
