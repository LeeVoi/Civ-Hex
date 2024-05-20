import 'package:civ_hex/components/game_board.dart';
import 'package:civ_hex/components/player_board/player_board.dart';
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
      body: StreamBuilder(
        stream: context.read<DataSource>().getGameState(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
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
                            child: GameBoard(gameState: snapshot.data!),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      PlayerBoard(
                          player: snapshot.data!.playersList[0],
                          width: width,
                          height: height / 5),
                      SizedBox(height: 10),
                      PlayerBoard(
                          player: snapshot.data!.playersList[1],
                          width: width,
                          height: height / 5),
                    ],
                  );
                } else {
                  return Row(
                    children: <Widget>[
                      SizedBox(width: 25,),
                      Expanded(
                          child: SizedBox(
                            width: width * (4 / 5),
                            height: height - height / 10,
                            child: AspectRatio(
                              aspectRatio: 1,
                              child: GameBoard(gameState: snapshot.data!),
                            ),
                          )),
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
