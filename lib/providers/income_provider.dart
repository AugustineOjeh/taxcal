import 'package:flutter_riverpod/flutter_riverpod.dart';

class IncomeNotifier extends StateNotifier<List<Map<String, dynamic>>> {
  IncomeNotifier() : super([]);

  void addEntry({
    required String description,
    required String category,
    required num amount,
    num? invested,
  }) {
    List<Map<String, dynamic>> allEntries = state;
    final Map<String, dynamic> newEntry = {
      'category': category,
      'description': description,
      'amount': amount,
      'isTaxable': isTaxable(category),
    };
    if (invested != null) {
      newEntry['isCapitalGain'] = true;
      newEntry['invested'] = invested;
    } else {
      newEntry['isCapitalGain'] = false;
    }
    allEntries.add(newEntry);
    state = allEntries;
  }

  void removeEntry(int index) {
    List<Map<String, dynamic>> allEntries = state;
    allEntries.removeAt(index);
    state = allEntries;
  }
}

final incomeProvider =
    StateNotifierProvider<IncomeNotifier, List<Map<String, dynamic>>>(
        (ref) => IncomeNotifier());

bool isTaxable(String category) {
  return !(category == 'ROI (Foreign Invesment)' ||
      category == 'Dividends/Bond Yields' ||
      category == 'Salary/Empoyment Bonus');
}
