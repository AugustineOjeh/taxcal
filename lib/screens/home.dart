import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taxcal/utils/dimensions.dart';
import 'package:taxcal/widgets/calculator_desktop.dart';
import 'package:taxcal/widgets/calculator_mobile.dart';
import 'package:taxcal/widgets/colors.dart';
import 'package:taxcal/widgets/country_currency_picker.dart';
import 'package:taxcal/widgets/texts.dart';

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  final String _country = 'Nigeria';
  final String _currency = '₦';

  @override
  void dispose() {
    super.dispose();
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
                                          AppBar(
                                              forceMaterialTransparency: true,
                                              title: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Row(
                                                        spacing: 10,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .end,
                                                        children: [
                                                          Image.asset(
                                                            'lib/assets/images/logo_light.png',
                                                            height: 24,
                                                            fit: BoxFit.contain,
                                                          ),
                                                          Container(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        4,
                                                                    vertical:
                                                                        2),
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8),
                                                                border: Border.all(
                                                                    width: 1,
                                                                    color: TCColor
                                                                        .border(
                                                                            context))),
                                                            child: TCText
                                                                .description(
                                                                    'v 0.1.0',
                                                                    context,
                                                                    isBold:
                                                                        true),
                                                          )
                                                        ]),
                                                    Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 8,
                                                                top: 4),
                                                        child: TCText.description(
                                                            'An Ojehs\' Project',
                                                            context))
                                                  ]),
                                              actions: [
                                                getCountry(context,
                                                    selectedCountry: _country)
                                              ]),
                                          SizedBox(height: 48),
                                          SizedBox(
                                              width: double.infinity,
                                              child: screenWidth < 768
                                                  ? CalculatorMobile(
                                                      currency: _currency)
                                                  : CalculatorDesktop(
                                                      currency: _currency)),
                                        ]))),
                          ),
                        ))))));
  }
}
