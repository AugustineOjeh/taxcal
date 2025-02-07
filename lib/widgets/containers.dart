import 'package:flutter/material.dart';
import 'package:taxcal/utils/display.dart';
import 'package:taxcal/styles/colors.dart';
import 'package:taxcal/styles/texts.dart';

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
          if (showBreakdown && entries.isNotEmpty)
            Column(children: [
              SizedBox(
                height: 8,
                child: Divider(
                  indent: 16,
                  endIndent: 16,
                  thickness: 0.5,
                  color: TCColor.border(context),
                ),
              ),
              ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.fromLTRB(16, 0, 0, 8),
                  itemCount: entries.length,
                  itemBuilder: (context, index) {
                    final entry = entries[index];
                    final String category = entry['category'];
                    final String? description = entry['description'];
                    final double amount = entry['amount'];

                    return Row(
                        spacing: 8,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                              child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                TCText.input(category, context),
                                if (description!.isNotEmpty)
                                  TCText.description(description, context,
                                      truncate: true)
                              ])),
                          TCText.input(
                              '${isExpense ? '-' : '+'}$amount', context,
                              isBold: true),
                          IconButton(
                              iconSize: 16,
                              padding: EdgeInsets.all(0),
                              visualDensity: VisualDensity.compact,
                              onPressed: () {
                                removeEntry(index);
                              },
                              icon: Icon(Icons.remove_circle_outline,
                                  color: TCColor.red(context)))
                        ]);
                  })
            ])
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
                            '$currency${(result['incomeTax'] + result['capitalGainsTax']).toStringAsFixed(2)}',
                            context))
                  ]),
            )),
        if (showBreakdown)
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 4),
                  SizedBox(
                      height: 8,
                      child: Divider(
                        thickness: 0.5,
                        color: TCColor.border(context),
                      )),
                  SizedBox(
                      child: Row(
                          spacing: 8,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                        Expanded(
                            child: TCText.input('Relief allowance', context,
                                color: TCColor.border(context))),
                        TCText.input(
                            result['reliefAllowance'].toStringAsFixed(2),
                            context,
                            isBold: true,
                            color: TCColor.border(context))
                      ])),
                  SizedBox(
                      child: Row(
                          spacing: 8,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                        Expanded(
                            child: TCText.input('Deductions', context,
                                color: TCColor.border(context))),
                        TCText.input(
                            result['deductions'].toStringAsFixed(2), context,
                            isBold: true, color: TCColor.border(context))
                      ])),
                  SizedBox(
                      child: Row(
                          spacing: 8,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                        Expanded(
                            child: TCText.input('Capital Gains', context,
                                color: TCColor.border(context))),
                        TCText.input(
                            result['capitalGains'].toStringAsFixed(2), context,
                            isBold: true, color: TCColor.border(context))
                      ])),
                  SizedBox(
                      child: Row(
                          spacing: 8,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                        Expanded(
                            child: TCText.input('Taxable Income', context,
                                color: TCColor.border(context))),
                        TCText.input(
                            result['taxableIncome'].toStringAsFixed(2), context,
                            isBold: true, color: TCColor.border(context))
                      ]))
                ]),
          )
      ]),
    );
  }
}
