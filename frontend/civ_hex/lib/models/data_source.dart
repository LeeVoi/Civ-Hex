import 'dart:convert';

import 'package:flutter/services.dart';

import 'gamestate.dart';


abstract class DataSource{
  Future<GameState> getGameState();
}

class FakeDataSource implements DataSource{
  @override
  Future<GameState> getGameState() async{
    String jsonString = await rootBundle.loadString('lib/gamestate_jsons/test.json');
    Map<String, dynamic> jsonData = jsonDecode(jsonString);
    return GameState.fromJson(jsonData);
  }

}