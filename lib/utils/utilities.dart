import 'package:intl/intl.dart';

class TCUtils {
  String formatAmount(double amount) {
    String formattedAmount = NumberFormat("#,###.##").format(amount);
    return formattedAmount;
  }
}
