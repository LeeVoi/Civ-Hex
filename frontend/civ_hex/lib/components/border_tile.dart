import 'package:flutter/material.dart';
import 'package:hexagon/hexagon.dart';

import 'hex_tile.dart';

class BorderTile extends StatefulWidget {
  HexTile parentHex;

  BorderTile({super.key, required this.parentHex});

  @override
  _BorderTileState createState() => _BorderTileState();
}

class _BorderTileState extends State<BorderTile> {

  @override
  Widget build(BuildContext context) {
    return HexagonWidget.pointy(
      width: 100,
      color: getBorderColor(),
      elevation: 8,
    );
  }

  Color getBorderColor() {
    if(widget.parentHex.owner == null){
      return Colors.grey;
    }
    if(widget.parentHex.owner?.playerName == "player1"){
      return Colors.blue;
    }
    if(widget.parentHex.owner?.playerName == "player2"){
      return Colors.red;
    }
    return Colors.grey;
  }
}