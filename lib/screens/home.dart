import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taxcal/utils/dimensions.dart';
import 'package:taxcal/widgets/colors.dart';
import 'package:taxcal/widgets/containers.dart';
import 'package:taxcal/widgets/country_currency_picker.dart';
import 'package:taxcal/widgets/form_holder.dart';
import 'package:taxcal/widgets/texts.dart';

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  final String _country = 'Nigeria';
  final String _currency = '₦';
  bool _calculationCompleted = false;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    // double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
              minHeight: getMinContentHeight(context), maxWidth: 1330),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: dynamicPadding(context),
                  child: SizedBox(
                    width: double.infinity,
                    child: GestureDetector(
                      onTap: () {
                        FocusScope.of(context).unfocus();
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          AppBar(
                              forceMaterialTransparency: true,
                              title: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Row(
                                        spacing: 10,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Image.asset(
                                            'lib/assets/images/logo_light.png',
                                            height: 24,
                                            fit: BoxFit.contain,
                                          ),
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 4, vertical: 2),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                border: Border.all(
                                                    width: 1,
                                                    color: TCColor.border(
                                                        context))),
                                            child: TCText.description(
                                                'v 0.1.0', context,
                                                isBold: true),
                                          )
                                        ]),
                                    Padding(
                                        padding:
                                            EdgeInsets.only(left: 8, top: 4),
                                        child: TCText.description(
                                            'An Ojehs\' Project', context))
                                  ]),
                              actions: [
                                getCountry(context, selectedCountry: _country)
                              ]),
                          SizedBox(height: 64),
                          SizedBox(
                            width: double.infinity,
                            child: Row(
                              spacing: 32,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: SizedBox(
                                    height: screenWidth >= 768
                                        ? getMinContentHeight(context)
                                        : null,
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.vertical,
                                      child: Column(spacing: 64, children: [
                                        if (screenWidth < 768)
                                          ConstrainedBox(
                                              constraints: BoxConstraints(
                                                  maxHeight: 358),
                                              child: TCContainer.pageTitle(
                                                  context)),
                                        ConstrainedBox(
                                          constraints:
                                              BoxConstraints(maxWidth: 450),
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 16, vertical: 20),
                                            decoration: BoxDecoration(
                                              color:
                                                  TCColor.containerBg(context),
                                              borderRadius:
                                                  BorderRadius.circular(18),
                                            ),
                                            child: Column(
                                              spacing: 64,
                                              children: [
                                                // ADD CONDITIONAL INCOME CONTAINER
                                                // ADD CONDITIONAL EXPENSE CONTAINER
                                                // ADD CONDITIONAL TAX CONTAINER
                                                if (!_calculationCompleted)
                                                  FormHolder(
                                                      currency: _currency),
                                              ],
                                            ),
                                          ),
                                        )
                                      ]),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
