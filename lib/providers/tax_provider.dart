import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taxcal/logics/tax_logics_nigeria.dart';

class TaxNotifier extends StateNotifier<Map<String, dynamic>> {
  TaxNotifier() : super({});

  void calculateTax({
    required List<Map<String, dynamic>> incomeEntries,
    required List<Map<String, dynamic>> expenseEntries,
  }) {
    final num deductions = NigeriaTaxLogics().sumDeductions(expenseEntries);
    final grossIncome = NigeriaTaxLogics().sumIncome(incomeEntries);
    final num reliefAllowance = NigeriaTaxLogics()
        .calculateReliefAllowance(grossIncome, expenseEntries);
    final num nonTaxableIncome =
        NigeriaTaxLogics().sumNonTaxableIncome(incomeEntries);
    final num investmentReturns =
        NigeriaTaxLogics().sumInvestmentReturns(incomeEntries);
    final num capitalGains = NigeriaTaxLogics().sumCapitalGains(incomeEntries);
    final num taxableIncome = grossIncome -
        (nonTaxableIncome + investmentReturns + deductions + reliefAllowance);
    final capitalGainsTax =
        NigeriaTaxLogics().calculateCapitalGainsTax(capitalGains);

    final incomeTax =
        NigeriaTaxLogics().calculateIncomeTax(taxableIncome, grossIncome);
    final Map<String, num> taxBreakdown = {
      'taxableIncome': taxableIncome,
      'capitalGains': capitalGains,
      'capitalGainsTax': capitalGainsTax,
      'deductions': deductions,
      'reliefAllowance': reliefAllowance,
      'incomeTax': incomeTax
    };
    state = taxBreakdown;
  }
}

final taxProvider = StateNotifierProvider<TaxNotifier, Map<String, dynamic>>(
    (ref) => TaxNotifier());
