import 'dart:convert';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:civ_hex/models/client_meta_data.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import 'gamestate.dart';

abstract class DataSource {
  Stream<GameState> getGameState();
  void joinQueue();
  void getPlayerId();
  void buyTile(num row, num column);
  void addGold(num wood, num stone, num grain, num sheep);
  void addPopulation();
  void endTurn();
}
class WebSocketDataSource implements DataSource {
  final bool isWeb = kIsWeb;
  late WebSocketChannel channel = WebSocketChannel.connect(Uri.parse(getConnectionString()));
  late Stream<dynamic>  broadcastStream = channel.stream.asBroadcastStream();

  ClientMetaData clientMetaData = ClientMetaData.getInstance(playerId: '', roomId: '');

  String getConnectionString(){
    return isWeb ? 'ws://localhost:8181' : 'ws://10.0.2.2:8181';
  }
  @override
  Stream<GameState> getGameState() {
    getPlayerId();
    return joinQueue();
  }
  
  @override
  void getPlayerId() async{
    channel.sink.add('{"eventType": "ClientWantsPlayerId"}');
    broadcastStream.listen((message){
      Map<String, dynamic> jsonData = jsonDecode(message);
      if(jsonData.containsKey('PlayerId')){
        clientMetaData.setPlayerId(jsonData['PlayerId']);
      }
    });
  }
  
  @override
  Stream<GameState> joinQueue(){
    channel.sink.add('{"eventType": "ClientWantsToEnterQueue"}');
    return broadcastStream.map((message) {
      Map<String, dynamic> jsonData = jsonDecode(message);

      // Check if the message is a GameState
      if (jsonData.containsKey('eventType')) {
        clientMetaData.setRoomId(jsonData['RoomId']);
        return GameState.fromJson(jsonData);
      } else {
        throw Exception('Received a non-GameState message from the server');
      }
    });
  }
  
  @override
  void buyTile(num row, num column){
    final purchaseTileMessage = jsonEncode({
      "eventType": "ClientWantsToPurchaseTile",
      "roomId": clientMetaData.getRoomId(), // Use the game ID (room ID)
      "playerId": clientMetaData.getPlayerId(),
      "rowIndex": row,
      "columnIndex": column,
    });
    channel.sink.add(purchaseTileMessage);
  }
  @override
  void addGold(num wood, num stone, num grain, num sheep){
    final buyGoldMessage = jsonEncode({
      "eventType": "ClientWantsToBuyGold",
      "roomId": clientMetaData.getRoomId(),
      "playerId": clientMetaData.getPlayerId(),
      "wood": wood,
      "stone": stone,
      "grain": grain,
      "sheep": sheep
    });
    channel.sink.add(buyGoldMessage);
  }

  @override
  void addPopulation(){
    final addPopulationMessage = jsonEncode({
      "eventType": "ClientWantsToBuyPopulation",
      "roomId": clientMetaData.getRoomId(),
      "playerId": clientMetaData.getPlayerId(),
      "population": 1
    });
    channel.sink.add(addPopulationMessage);
  }

  @override
  void endTurn(){
    final endTurnMessage= jsonEncode({
      "eventType": "ClientWantsToEndTurn",
      "roomId": clientMetaData.getRoomId(),
      "playerId": clientMetaData.getPlayerId()
    });
    print(endTurnMessage);
    channel.sink.add(endTurnMessage);
  }
}

