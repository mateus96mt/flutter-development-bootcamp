import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: challenge1(),
    );
  }

  Widget challenge1() {
    //https://drive.google.com/uc?export=download&id=1k7oW5qVLJqzw_lEFsOFS_qKmkGjBX1pL

    return Scaffold(
      backgroundColor: Colors.teal,
      body: SafeArea(
        child: Row(
          children: [
            Container(
              width: 100,
              color: Colors.red,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    color: Colors.yellow,
                  ),
                  Container(
                    width: 100,
                    height: 100,
                    color: Colors.yellow.withOpacity(0.5),
                  ),
                ],
              ),
            ),
            Container(
              width: 100,
              color: Colors.blue,
            )
          ],
        ),
      ),
    );
  }
}
