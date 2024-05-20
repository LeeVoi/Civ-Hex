import 'dart:convert';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/services.dart';
import 'package:web_socket_channel/html.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/status.dart' as status;

import 'gamestate.dart';

abstract class DataSource {
  Stream<GameState> getGameState();
}
/**
class FakeDataSource implements DataSource {
  @override
  Stream<GameState> getGameState() async {
    String jsonString =
        await rootBundle.loadString('lib/gamestate_jsons/test.json');
    Map<String, dynamic> jsonData = jsonDecode(jsonString);
    return GameState.fromJson(jsonData);
  }
}
    **/

class WebSocketDataSource implements DataSource {
  final channel = kIsWeb
      ? HtmlWebSocketChannel.connect('ws://localhost:8181')
      : IOWebSocketChannel.connect('ws://localhost:8181');

  @override
  Stream<GameState> getGameState() {
    // Send a message to join the queue
    channel.sink.add('{"eventType": "ClientWantsToEnterQueue"}');

    // Convert the channel's stream of messages into a stream of GameState objects
    return channel.stream.map((message) {
      Map<String, dynamic> jsonData = jsonDecode(message);

      // Check if the message is a GameState
      if (jsonData.containsKey('eventType')) {
        return GameState.fromJson(jsonData);
      } else {
        throw Exception('Received a non-GameState message from the server');
      }
    });
  }
}

