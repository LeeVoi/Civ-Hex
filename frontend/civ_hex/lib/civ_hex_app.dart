import 'package:civ_hex/components/game_screen.dart';
import 'package:flutter/material.dart';

class CivHexApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      title: 'Civ Hex',
      home: GameScreen(),
    );
  }
}


