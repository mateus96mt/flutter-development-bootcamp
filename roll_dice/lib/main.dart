import 'dart:math';

import 'package:flutter/material.dart';

const int maxDiceValue = 6;

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int rightDiceValue = 1, leftDiceValue = 1;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.red,
        body: SafeArea(
          child: Center(
            child: Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: changeDicesValue,
                    child: Image.asset('assets/images/dice$leftDiceValue.png'),
                  ),
                ),
                Expanded(
                  child: TextButton(
                    onPressed: changeDicesValue,
                    child: Image.asset('assets/images/dice$rightDiceValue.png'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void changeDicesValue() {
    setState(() {
      rightDiceValue = Random().nextInt(maxDiceValue) + 1;
      leftDiceValue = Random().nextInt(maxDiceValue) + 1;
    });
  }
}
