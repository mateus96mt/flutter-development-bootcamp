import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final player = AudioPlayer();
  List<Color> colors = [
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.greenAccent,
    Colors.green,
    Colors.blue,
    Colors.purple
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Column(
            children: [
              for (int i = 0; i < colors.length; i++)
                Expanded(
                  child: playButton(colors[i], i + 1),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget playButton(Color color, int audioIndex) {
    return TextButton(
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
      ),
      child: Container(
        color: color,
      ),
      onPressed: () async {
        await player.setAsset('assets/note$audioIndex.wav');
        player.play();
      },
    );
  }
}
