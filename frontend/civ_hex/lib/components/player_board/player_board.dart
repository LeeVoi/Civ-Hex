import 'package:civ_hex/components/player_board/display_hex.dart';
import 'package:civ_hex/models/data_source.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/player.dart';

class PlayerBoard extends StatefulWidget {
  Player player;
  double width;
  double height;

  PlayerBoard(
      {super.key,
      required this.player,
      required this.width,
      required this.height});

  @override
  _PlayerBoardState createState() => _PlayerBoardState();
}

class _PlayerBoardState extends State<PlayerBoard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      width: widget.width,
      color: getColorByPlayer(),
      child: Column(
        children: [
          Text(
            getPlayerName(),
            style: const TextStyle(fontSize: 20),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              DisplayHex(width: widget.height, resource: "Grain", amount: widget.player.grain),
              DisplayHex(width: widget.height, resource: "Sheep", amount: widget.player.sheep),
              DisplayHex(width: widget.height, resource: "Wood", amount: widget.player.wood),
              DisplayHex(width: widget.height, resource: "Stone", amount: widget.player.stone),
            ],
          ),
          SizedBox(height: widget.height/20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Icon(Icons.emoji_events),
              Text(widget.player.victoryPoints.toString()),
              const Icon(Icons.monetization_on_outlined),
              Text(widget.player.gold.toString()),
              const Icon(Icons.person),
              Text(widget.player.population.toString())
            ],
          ),
        ],
      ),
    );
  }

  void addPopulation(){
    print(widget.player.population);
  }

  Color getColorByPlayer() {
    switch (widget.player.playerName) {
      case "player1":
        return Colors.blue;
      case "player2":
        return Colors.red;
      default:
        return Colors.blue;
    }
  }

  String getPlayerName() {
    switch (widget.player.playerName) {
      case "player1":
        return "Player 1";
      case "player2":
        return "Player 2";
      default:
        return "Player";
    }
  }
}
