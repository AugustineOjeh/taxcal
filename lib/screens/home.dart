import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taxcal/widgets/fields.dart';

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  final FocusNode _focusNode = FocusNode(); // Create FocusNode
  final _dummyController = TextEditingController();

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: SizedBox(
                width: 400,
                child: TCField.dropdown(
                    context: context,
                    items: ['Man', 'Woman', 'Toddler', 'Anybody else'],
                    onChanged: (value) {},
                    label: 'Labeling',
                    hint: '0.00',
                    controller: _dummyController),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
