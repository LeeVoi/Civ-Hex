import 'package:civ_hex/components/game_board.dart';
import 'package:civ_hex/components/player_board.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/data_source.dart';

class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: context.read<DataSource>().getGameState(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 50.0),
                    child: GameBoard(gameState: snapshot.data!),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: PlayerBoard(player: snapshot.data!.playersList[0]),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: PlayerBoard(player: snapshot.data!.playersList[1]),
                ),
              ],
            );
          } else {
            // You can return a loading indicator here
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }

}
