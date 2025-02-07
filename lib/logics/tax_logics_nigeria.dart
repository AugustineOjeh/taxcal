class NigeriaTaxLogics {
  bool isTaxable(String category) {
    return !(category == 'ROI (Foreign Invesment)' ||
        category == 'Dividends/Bond Yields' ||
        category == 'Salary/Empoyment Bonus');
  }

  bool isDeductible(String category) {
    return category == 'Healthcare' ||
        category == 'Insurance payment' ||
        category == 'Rental (business office)' ||
        category == 'Subscriptions (business)' ||
        category == 'Charitable donations' ||
        category == 'Tips & gifts' ||
        category == 'Raw material purchase';
  }

  double sumDeductions(List<Map<String, dynamic>> expenseEntries) {
    double totalDeductions = expenseEntries
        .where((entry) => entry['isDeductible'] == true)
        .fold(0, (sum, entry) => sum + (entry['amount'] as double));
    return totalDeductions;
  }

  double sumNonTaxableIncome(List<Map<String, dynamic>> incomeEntries) {
    double nonTaxableIncome = incomeEntries
        .where((entry) => entry['isTaxable'] == false)
        .fold(0, (sum, entry) => sum + (entry['amount'] as double));
    return nonTaxableIncome;
  }

  double sumInvestmentReturns(List<Map<String, dynamic>> incomeEntries) {
    double roi = incomeEntries
        .where((entry) => entry['isCapitalGain'] == true)
        .fold(0, (sum, entry) => sum + (entry['amount'] as double));
    return roi;
  }

  double sumCapitalGains(List<Map<String, dynamic>> incomeEntries) {
    final List<Map<String, dynamic>> returns =
        incomeEntries.where((entry) => entry['isCapitalGain'] == true).toList();
    double capitalGains = returns
        .map((entry) => entry["amount"] - entry["invested"])
        .where((profit) => profit >= 0)
        .fold(0, (sum, profit) => sum + profit);
    return capitalGains;
  }

  double sumIncome(List<Map<String, dynamic>> incomeEntries) {
    return incomeEntries.fold(
        0, (sum, entry) => sum + (entry['amount'] as double));
  }

  double calculateCapitalGainsTax(double capitalGains) {
    return capitalGains * 0.1;
  }

  double getBaseAllowance(double grossIncome) {
    if ((grossIncome * 0.01) > 200000) {
      return grossIncome * 0.01;
    } else {
      return 200000;
    }
  }

  double calculateReliefAllowance(
      double grossIncome, List<Map<String, dynamic>> expenseEntries) {
    double baseAllowance = getBaseAllowance(grossIncome);

    List<Map<String, dynamic>> contributions = expenseEntries
        .where((entry) =>
            entry['category'] == 'Pension contribution' ||
            entry['category'] == 'NHF contribution' ||
            entry['category'] == 'Mortgage payment')
        .toList();
    double deductibleContributions =
        contributions.fold(0, (sum, item) => sum + (item['amount'] as double));
    double extraAllowance = (grossIncome - deductibleContributions) * 0.2;
    return baseAllowance + extraAllowance;
  }

  double calculateIncomeTax(double taxableIncome, double grossIncome) {
    if (grossIncome <= 840000) return 0;
    if (taxableIncome < (grossIncome * 0.01)) {
      return grossIncome * 0.01;
    } else if (taxableIncome > (grossIncome * 0.01) &&
        taxableIncome <= 300000) {
      return taxableIncome * 0.07;
    } else if (taxableIncome > 300000 && taxableIncome <= 600000) {
      final double firstTierTax = 21000;
      final double seconTierTax = (taxableIncome - 300000) * 0.11;
      return firstTierTax + seconTierTax;
    } else if (taxableIncome > 600000 && taxableIncome <= 1100000) {
      final double firstTierTax = 21000;
      final double secondTierTax = 33000;
      final double thirdTierTax = (taxableIncome - 600000) * 0.15;
      return firstTierTax + secondTierTax + thirdTierTax;
    } else if (taxableIncome > 1100000 && taxableIncome <= 1600000) {
      final double firstTierTax = 21000;
      final double secondTierTax = 33000;
      final double thirdTierTax = 75000;
      final double fourthTierTax = (taxableIncome - 1100000) * 0.19;
      return firstTierTax + secondTierTax + thirdTierTax + fourthTierTax;
    } else if (taxableIncome > 1600000 && taxableIncome <= 3200000) {
      final double firstTierTax = 21000;
      final double secondTierTax = 33000;
      final double thirdTierTax = 75000;
      final double fourthTierTax = 95000;
      final double fifthTierTax = (taxableIncome - 1600000) * 0.21;
      return firstTierTax +
          secondTierTax +
          thirdTierTax +
          fourthTierTax +
          fifthTierTax;
    } else {
      final double firstTierTax = 21000;
      final double secondTierTax = 33000;
      final double thirdTierTax = 75000;
      final double fourthTierTax = 95000;
      final double fifthTierTax = 336000;
      final double lastTierTax = (taxableIncome - 3200000) * 0.24;
      return firstTierTax +
          secondTierTax +
          thirdTierTax +
          fourthTierTax +
          fifthTierTax +
          lastTierTax;
    }
  }
}
