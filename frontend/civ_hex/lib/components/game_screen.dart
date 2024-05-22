import 'package:civ_hex/components/game_board.dart';
import 'package:civ_hex/components/player_board/player_board.dart';
import 'package:civ_hex/enums/game_status.dart';
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
      body: StreamBuilder(
        stream: context.read<DataSource>().getGameState(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data!.gameStatus == GameStatus.active) {
            return LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                final isPortrait =
                    constraints.maxHeight > constraints.maxWidth * .65;
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
                            child: GameBoard(gameState: snapshot.data!),
                          ),
                        ),
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          BuyGoldButton(),
                          AddPopulationButton(),
                          EndTurnButton()
                        ],
                      ),
                      const SizedBox(height: 10),
                      PlayerBoard(
                          player: snapshot.data!.playersList[0],
                          width: width,
                          height: height / 5),
                      const SizedBox(height: 10),
                      PlayerBoard(
                          player: snapshot.data!.playersList[1],
                          width: width,
                          height: height / 5),
                    ],
                  );
                } else if(snapshot.hasData && snapshot.data!.gameStatus == GameStatus.complete)
                {
                  return EndScreen(snapshot.data!);
                }

                else {
                  return Row(
                    children: <Widget>[
                      const SizedBox(
                        width: 25,
                      ),
                      Expanded(
                          child:  AspectRatio(
                          aspectRatio: 1,
                          child: GameBoard(gameState: snapshot.data!),
                        ),
                      ),
                      const Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          BuyGoldButton(),
                          SizedBox(height: 10,),
                          AddPopulationButton(),
                          SizedBox(height: 10,),
                          EndTurnButton()
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Expanded(
                            child: PlayerBoard(
                                player: snapshot.data!.playersList[0],
                                width: width / 3,
                                height: height / 2),
                          ),
                          SizedBox(height: 10),
                          Expanded(
                            child: PlayerBoard(
                                player: snapshot.data!.playersList[1],
                                width: width / 3,
                                height: height / 2),
                          ),
                        ],
                      ),
                    ],
                  );
                }
              },
            );
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}

class EndTurnButton extends StatelessWidget {
  const EndTurnButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        context.read<DataSource>().endTurn();
      },
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
          foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          )),
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

class BuyGoldButton extends StatelessWidget {
  const BuyGoldButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        context.read<DataSource>().addGold();
      },
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.amber),
          foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          )),
      child: const Text("Buy Gold"),
    );
  }
}

 class EndScreen extends StatelessWidget{

  GameState gameState;

  EndScreen({
    super.key,
    required this.gameState
  })


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
    return Container(
      child: Text('')

    );
  }

 }
