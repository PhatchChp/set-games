import 'package:flutter/material.dart';
import 'package:setgame/view/view_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SetGames',
      theme: ThemeData(
        // colorSchemeSeed: Colors.blue,
        // brightness: Brightness.light,

        useMaterial3: true,
      ),
      home: const ViewScreen(),
    );
  }
}
