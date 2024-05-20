import 'package:civ_hex/components/player_board/player_board.dart';
import 'package:flutter/material.dart';
import 'package:hexagon/hexagon.dart';

class DisplayHex extends StatelessWidget {
  const DisplayHex({
    super.key,
    required this.width,
    required this.resource,
    required this.amount
  });

  final double width;
  final String resource;
  final num amount;

  @override
  Widget build(BuildContext context) {
    return HexagonWidget.pointy(
      width: width/3.8,
      color: getTileColorByTileType(),
      elevation: 10,
      child: Text(amount.toString(), style: TextStyle(color: Colors.black, fontSize: width/15)),
    );
  }

  Color getTileColorByTileType(){
    switch(resource){
      case "Wood":
        return Colors.brown;
      case "Sheep":
        return Colors.green;
      case "Stone":
        return Colors.blueGrey;
      case "Grain":
        return Colors.yellow;
      default:
        return Colors.black;
    }
  }
}
