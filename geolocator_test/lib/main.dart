import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

void main() {
  runApp(
    MaterialApp(
      home: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        child: Text('Get location'),
        onPressed: () {
          getLocation();
        },
      ),
    );
  }

  void getLocation() async {
    Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.low,
    ).then(
      (position) {
        print("MINHA LOCALIZACAO: ");
      },
    ).catchError(
      (onError) {
        print(onError);
      },
    );
  }
}
