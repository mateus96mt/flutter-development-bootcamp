import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int answerValue = 1;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text('Ask Me Anything'),
          ),
        ),
        backgroundColor: Colors.lightBlueAccent,
        body: SafeArea(
          child: Center(
            child: TextButton(
              onPressed: getAnswer,
              child: Image.asset('assets/images/ball$answerValue.png'),
            ),
          ),
        ),
      ),
    );
  }

  void getAnswer() {
    setState(() {
      this.answerValue = Random().nextInt(5) + 1;
    });
  }
}
