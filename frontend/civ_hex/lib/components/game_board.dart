import 'package:flutter/material.dart';
import 'package:hexagon/hexagon.dart';

import '../models/gamestate.dart';
import 'border_tile.dart';
import 'hex_tile.dart';

class GameBoard extends StatefulWidget {
  GameState gameState;

  GameBoard({super.key, required this.gameState});

  @override
  _GameBoardState createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // BorderTile grid
        HexagonOffsetGrid.oddPointy(
          columns: 6,
          rows: 6,
          buildTile: (col, row) => HexagonWidgetBuilder(
              elevation: 2,
              padding: 0),
          buildChild: (col, row) {
            if (row < widget.gameState.hexTilesList.length &&
                col < widget.gameState.hexTilesList[row].length) {
              return BorderTile(
                  parentHex: widget.gameState.hexTilesList[row][col]);
            } else {
              return Scaffold();
            }
          },
        ),
        // HexTile grid
        HexagonOffsetGrid.oddPointy(
          columns: 6,
          rows: 6,
          buildTile: (col, row) => HexagonWidgetBuilder(
              elevation: 2,
              padding: 4),
          buildChild: (col, row) {
            if (row < widget.gameState.hexTilesList.length &&
                col < widget.gameState.hexTilesList[row].length) {
              return widget.gameState.hexTilesList[row][col];
            } else {
              return Scaffold();
            }
          },
        ),
      ],
    );
  }
}
