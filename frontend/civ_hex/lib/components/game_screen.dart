import 'package:civ_hex/components/game_board.dart';
import 'package:civ_hex/components/player_board/player_board.dart';
import 'package:civ_hex/enums/game_status.dart';
import 'package:civ_hex/models/client_meta_data.dart';
import 'package:civ_hex/models/gamestate.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/data_source.dart';
import '../models/player.dart';

class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
@override
Widget build(BuildContext context) {
  return Scaffold(
    body: StreamBuilder<GameState>(
      stream: context.read<DataSource>().getGameState(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting || !snapshot.hasData) {

          return const Center(
              child: CircularProgressIndicator()
          );
          } else {
          GameState gameState = snapshot.data!;
          print('Game state received: ${gameState.gameStatus}');

          if (gameState.gameStatus == GameStatus.complete) {
            return EndScreen(gameState: gameState);

          } else if (gameState.gameStatus == GameStatus.active) {
            return LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                final isPortrait = constraints.maxHeight > constraints.maxWidth * .65;
                double width = constraints.maxWidth;
                double height = constraints.maxHeight;

                if (isPortrait) {
                  return Column(
                    children: <Widget>[
                      SizedBox(height: 50),
                      Expanded(
                        child: Center(
                          child: AspectRatio(
                            aspectRatio: 1,
                            child: GameBoard(gameState: gameState),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          AddPopulationButton(),
                          EndTurnButton(gameState: snapshot.data!),
                        ],
                      ),
                      const SizedBox(height: 10),
                      PlayerBoard(
                        player: gameState.playersList[0],
                        width: width,
                        height: height / 5,
                      ),
                      const SizedBox(height: 10),
                      PlayerBoard(
                        player: gameState.playersList[1],
                        width: width,
                        height: height / 5,
                      ),
                    ],
                  );
                } else {
                  return Row(
                    children: <Widget>[
                      const SizedBox(width: 25),
                      Expanded(
                        child: AspectRatio(
                          aspectRatio: 1,
                          child: GameBoard(gameState: gameState),
                        ),
                      ),
                       Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SizedBox(height: 10),
                          AddPopulationButton(),
                          SizedBox(height: 10),
                          EndTurnButton(gameState: snapshot.data!),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Expanded(
                            child: PlayerBoard(
                              player: gameState.playersList[0],
                              width: width / 3,
                              height: height / 2,
                            ),
                          ),
                          SizedBox(height: 10),
                          Expanded(
                            child: PlayerBoard(
                              player: gameState.playersList[1],
                              width: width / 3,
                              height: height / 2,
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                }
              },
            );
          } else {
            return const Center(child: Text('Unknown game state'));
          }
        }
      },
    ),
  );
}
}

class EndTurnButton extends StatelessWidget {

  GameState gameState;

  EndTurnButton({
    required this.gameState,
    super.key,
  });

  bool _isButtonEnabled() {
    var playerId = ClientMetaData.getInstance(playerId: "", roomId: "").getPlayerId();
    var isTurnEven = gameState.turnNumber % 2 == 1;
    var isPlayer0 = gameState.playersList[0].wsId == playerId;
    var isPlayer1 = gameState.playersList[1].wsId == playerId;

    return (isTurnEven && isPlayer0) || (!isTurnEven && isPlayer1);
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: _isButtonEnabled()
          ? () {
        context.read<DataSource>().endTurn();
      }
          : null, // Disable the button if the condition is not met
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
        foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      child: const Text("End Turn"),
    );
  }
}
class AddPopulationButton extends StatelessWidget {
  const AddPopulationButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        context.read<DataSource>().addPopulation();
      },
      style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all<Color>(Colors.lightBlueAccent),
          foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          )),
      child: const Text("Add Population"),
    );
  }
}

 class EndScreen extends StatelessWidget{

  final GameState gameState;

  EndScreen({
    super.key,
    required this.gameState
  });


  Player? findWinningPlayer(GameState gameState){

    for(var player in gameState.playersList) {

      if(player.victoryPoints >= 50)
      {
        return player;
      }
    }
    return null;
  }


  @override
  Widget build(BuildContext context) {
    Player? winner = findWinningPlayer(gameState);

    return Center(
      child: AlertDialog(
        title: Text('Game Over'),
        content: Text(winner != null
            ? 'Congratulations, ${winner.playerName}! You have won the game!'
            : 'The game has ended in a draw.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Change to navigate back to homeScreen.
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }
 }
