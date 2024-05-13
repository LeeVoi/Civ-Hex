import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'components/game_board.dart';
import 'models/gamestate.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  String jsonString = await rootBundle.loadString('lib/gamestate_jsons/test.json');
  Map<String, dynamic> jsonData = jsonDecode(jsonString);
  GameState gameState = GameState.fromJson(jsonData);


  runApp(MaterialApp(
    home: Scaffold(
      body: GameBoard(gameState: gameState),
    ),
  ));
}
