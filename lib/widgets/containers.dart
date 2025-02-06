import 'package:flutter/material.dart';
import 'package:taxcal/utils/display.dart';
import 'package:taxcal/widgets/colors.dart';
import 'package:taxcal/widgets/texts.dart';

class TCContainer {
  static Widget income(
    BuildContext context, {
    required String amount,
    String? title,
    String? description,
    required String currency,
    required bool isExpense,
    required List<Map<String, dynamic>> entries,
    required void Function(int index) removeEntry,
    required bool showBreakdown,
    void Function()? onTap,
  }) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
            color: TCColor.border(context, opacity: 0.2),
            borderRadius: BorderRadius.circular(12)),
        child: Column(spacing: 4, mainAxisSize: MainAxisSize.min, children: [
          GestureDetector(
              onTap: onTap,
              child: Container(
                color: Colors.transparent,
                child: Column(
                  spacing: 4,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          TCText.headingSmall(
                              title ?? (isExpense ? 'Expenses' : 'Income'),
                              context),
                          Expanded(child: SizedBox()),
                          Icon(
                            showBreakdown
                                ? Icons.expand_more_outlined
                                : Icons.chevron_right_outlined,
                            color: TCColor.border(context),
                            size: 20,
                          )
                        ]),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          TCText.input(
                              description ??
                                  (isExpense
                                      ? 'All your spending'
                                      : 'Sum of money earned'),
                              context),
                          Expanded(child: SizedBox()),
                          sum(context,
                              amount: amount,
                              currency: currency,
                              isExpenses: isExpense)
                        ]),
                  ],
                ),
              )),
          if (showBreakdown)
            ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: entries.length,
                itemBuilder: (context, index) {
                  final entry = entries[index];
                  final String category = entry['category'];
                  final String? description = entry['description'];
                  final double amount = entry['amount'];

                  return Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IconButton(
                            iconSize: 16,
                            onPressed: () {
                              removeEntry(index);
                            },
                            icon: Icon(
                              Icons.remove_circle_outline,
                              color: TCColor.red(context),
                            )),
                        Expanded(
                            child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                              TCText.input(category, context),
                              if (description != null)
                                TCText.description(description, context,
                                    truncate: true)
                            ])),
                        TCText.label(amount.toString(), context)
                      ]);
                })
        ]));
  }

  static Widget sum(
    BuildContext context, {
    required String amount,
    required String currency,
    required bool isExpenses,
  }) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        decoration: BoxDecoration(
            color: isExpenses
                ? TCColor.red(context, opacity: 0.15)
                : TCColor.green(context, opacity: 0.15),
            borderRadius: BorderRadius.circular(36)),
        child: TCText.description('$currency $amount', context));
  }

  static Widget pageTitle(BuildContext context) {
    return Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 32),
        decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(TCDisplay.getImageUrl(TCDisplay().urls())),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.black.withValues(alpha: 0.5),
                  BlendMode.darken,
                )),
            borderRadius: BorderRadius.circular(36)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.max,
          children: [
            TCText.title('Tax Calculator', context),
            SizedBox(
              height: 8,
            )
          ],
        ));
  }

  static Widget tax(
    BuildContext context, {
    String title = 'Tax',
    String description = 'Amount payable',
    required bool showBreakdown,
    required String currency,
    required Map<String, dynamic> result,
    void Function()? onTap,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
          color: TCColor.secondary(context),
          borderRadius: BorderRadius.circular(12)),
      child: Column(spacing: 4, mainAxisSize: MainAxisSize.min, children: [
        GestureDetector(
            onTap: onTap,
            child: Container(
              color: Colors.transparent,
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        spacing: 8,
                        children: [
                          TCText.headingSmall(title, context,
                              color: TCColor.foreground(context)),
                          TCText.description(description, context,
                              color: TCColor.foreground(context)),
                        ]),
                    Expanded(child: SizedBox()),
                    Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                        decoration: BoxDecoration(
                            color: TCColor.foreground(context),
                            borderRadius: BorderRadius.circular(8)),
                        child: TCText.label(
                            '$currency ${result['incomeTax'] + result['capitalGainsTax']}',
                            context))
                  ]),
            )),
        if (showBreakdown)
          Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                      Icon(Icons.circle,
                          size: 8, color: TCColor.border(context)),
                      Expanded(
                          child: TCText.input('Relief allowance', context)),
                      TCText.label(result['reliefAllowance'], context)
                    ])),
                SizedBox(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                      Icon(Icons.circle,
                          size: 8, color: TCColor.border(context)),
                      Expanded(child: TCText.input('Deductions', context)),
                      TCText.label(result['deductions'], context)
                    ])),
                SizedBox(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                      Icon(Icons.circle,
                          size: 8, color: TCColor.border(context)),
                      Expanded(child: TCText.input('Capital Gains', context)),
                      TCText.label(result['capitalGains'], context)
                    ])),
                SizedBox(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                      Icon(Icons.circle,
                          size: 8, color: TCColor.border(context)),
                      Expanded(child: TCText.input('Taxable Income', context)),
                      TCText.label(result['taxableIncome'], context)
                    ]))
              ])
      ]),
    );
  }
}
