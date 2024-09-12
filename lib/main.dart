import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  runApp(const MaterialApp(
      debugShowCheckedModeBanner: false, home: RandomizerPage()));
}

class InheritedNumber extends InheritedWidget {
  const InheritedNumber(
      {required this.number, required super.child, super.key});

  final int number;

  static InheritedNumber? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<InheritedNumber>();
  }

  static InheritedNumber of(BuildContext context) {
    final InheritedNumber? result = maybeOf(context);
    assert(result != null, 'Не найдено InheritNumber в этом context');
    return result!;
  }

  @override
  bool updateShouldNotify(InheritedNumber oldWidget) =>
      number != oldWidget.number;
}

class RandomizerPage extends StatefulWidget {
  const RandomizerPage({super.key});

  @override
  State<RandomizerPage> createState() => _RandomizerPageState();
}

class _RandomizerPageState extends State<RandomizerPage> {
  final rand = Random();
  late int _randomNumber = rand.nextInt(100);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Генерация случайных чисел',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
      ),
      body: InheritedNumber(
          number: _randomNumber,
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '$_randomNumber',
                  style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 80),
                // _Child(),
                // const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _randomNumber = rand.nextInt(100);
                    });
                  },
                  child: const Text(
                    'Обновить',
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 15),
                    textStyle: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    shadowColor: Colors.black,
                  ),
                ),
              ],
            ),
          )),
    );
  }
}

  // class _Child extends StatelessWidget {
  //     @override
  //   Widget build(BuildContext context) {
  //     return Text(
  //       'Число из _Child: ${InheritedNumber.of(context).number}'
  //     );
  //   }
  // }

