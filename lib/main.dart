import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taxcal/screens/home.dart';
import 'package:taxcal/utils/display.dart';

void main() {
  runApp(ProviderScope(child: TaxCal()));
}

class TaxCal extends StatelessWidget {
  const TaxCal({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TaxCal',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Inter',
        scaffoldBackgroundColor: Color(0xFFFFFBF4),
        textTheme: TextTheme(
            displayLarge: TextStyle(
                fontFamily: 'Gayathri',
                fontWeight: FontWeight.w700,
                fontSize: displayFontSize(context),
                color: Colors.white),
            bodyMedium: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).colorScheme.onSurface),
            bodyLarge: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).colorScheme.onSurface),
            labelSmall: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Theme.of(context).colorScheme.onSurface),
            bodySmall: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Theme.of(context).colorScheme.onSurface)),
        colorScheme: ColorScheme(
            brightness: Brightness.light,
            primary: Color(0xFFFF9500),
            onPrimary: Color(0xFFFFFBF4),
            secondary: Color(0xFF1D1B20),
            onSecondary: Color(0xFFFFFBF4),
            error: Color(0xFFFF3B30),
            onError: Color(0xFFFFFBF4),
            surface: Color(0xFFF2ECE3),
            onSurface: Color(0xFF413F3C),
            secondaryContainer: Color(0xFF9E9B95)),
        useMaterial3: true,
      ),
      home: Home(),
    );
  }
}
