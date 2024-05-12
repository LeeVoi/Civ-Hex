import 'package:civ_hex/components/hex_tile.dart';
import 'package:civ_hex/enums/game_status.dart';
import 'package:civ_hex/models/player.dart';

class GameState {
  GameStatus gameStatus;
  num turnNumber;
  String roomId;
  List<Player> playersList;
  List<List<HexTile>> hexTilesList;

  GameState(
      {required this.gameStatus,
      required this.turnNumber,
      required this.roomId,
      required this.playersList,
      required this.hexTilesList});

  factory GameState.fromJson(Map<String, dynamic> json) {
    return GameState(
      gameStatus: GameStatus.values[json['gameStatus']],
      turnNumber: json['turnNumber'],
      roomId: json['roomId'],
      playersList: (json['playersList'] as List).map((i) => Player.fromJson(i)).toList(),
      hexTilesList: (json['hexTilesList'] as List).map((i) => (i as List).map((j) => HexTile.fromJson(j)).toList()).toList(),
    );
  }
}
