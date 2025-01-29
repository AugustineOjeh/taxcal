import 'package:flutter/material.dart';
import 'package:taxcal/utils/display.dart';
import 'package:taxcal/utils/image_urls.dart';
import 'package:taxcal/widgets/colors.dart';
import 'package:taxcal/widgets/texts.dart';

class TCContainer {
  static Widget income(
    BuildContext context, {
    required String amount,
    required String title,
    required String description,
    required String currency,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
          color: TCColor.containerBg(context),
          borderRadius: BorderRadius.circular(12)),
      child: Column(
        spacing: 4,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TCText.headingSmall(title, context),
                Expanded(child: SizedBox()),
                Icon(
                  Icons.chevron_right_outlined,
                  color: TCColor.border(context),
                  size: 20,
                )
              ]),
          Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TCText.input(description, context),
                Expanded(child: SizedBox()),
                sum(context,
                    amount: amount, currency: currency, isExpenses: true)
              ]),
        ],
      ),
    );
  }

  static Widget sum(
    BuildContext context, {
    required String amount,
    required String currency,
    required bool isExpenses,
  }) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
            color: isExpenses
                ? TCColor.red(context, opacity: 0.15)
                : TCColor.green(context, opacity: 0.15),
            borderRadius: BorderRadius.circular(36)),
        child: TCText.description('$currency $amount', context));
  }

  static Widget pageTitle(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
        padding: EdgeInsets.all(screenWidth > 767 ? 80 : 40),
        width: double.infinity,
        height: screenWidth > 767 ? 780 : 358,
        decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(getImageUrl(DisplayImage().urls())),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                Colors.black.withValues(alpha: 0.4),
                BlendMode.darken,
              ),
            ),
            borderRadius: BorderRadius.circular(36)),
        child: TCText.title('Tax Calculator', context));
  }

  static Widget tax(
    BuildContext context, {
    String title = 'Tax',
    String description = 'Total amount payable',
    required String amount,
    required String currency,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
          color: TCColor.secondary(context),
          borderRadius: BorderRadius.circular(12)),
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
                    color: TCColor.forground(context)),
                TCText.description(description, context,
                    color: TCColor.forground(context)),
              ]),
          Expanded(child: SizedBox()),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
                color: TCColor.forground(context),
                borderRadius: BorderRadius.circular(8)),
            child: TCText.label('$currency $amount', context),
          )
        ],
      ),
    );
  }
}
