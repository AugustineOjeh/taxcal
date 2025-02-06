import 'package:flutter_riverpod/flutter_riverpod.dart';

class ExpenseNotifier extends StateNotifier<List<Map<String, dynamic>>> {
  ExpenseNotifier() : super([]);

  void addEntry({
    required String description,
    required String category,
    required num amount,
  }) {
    List<Map<String, dynamic>> allEntries = state;
    final Map<String, dynamic> newEntry = {
      'category': category,
      'description': description,
      'amount': amount,
      'isDeductible': isDeductible(category),
    };
    allEntries.add(newEntry);
    state = allEntries;
  }

  void removeEntry(int index) {
    List<Map<String, dynamic>> allEntries = state;
    allEntries.removeAt(index);
    state = allEntries;
  }
}

final expenseProvider =
    StateNotifierProvider<ExpenseNotifier, List<Map<String, dynamic>>>(
        (ref) => ExpenseNotifier());

bool isDeductible(String category) {
  return category == 'Healthcare' ||
      category == 'Insurance payment' ||
      category == 'Rental (business office)' ||
      category == 'Subscriptions (business)' ||
      category == 'Charitable donations' ||
      category == 'Tips & gifts' ||
      category == 'Raw material purchase';
}
