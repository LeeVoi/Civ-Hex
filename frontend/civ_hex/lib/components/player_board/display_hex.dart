import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hexagon/hexagon.dart';
import 'package:provider/provider.dart';
import 'package:civ_hex/models/data_source.dart';

class DisplayHex extends StatefulWidget {
  const DisplayHex({
    super.key,
    required this.width,
    required this.resource,
    required this.amount,
  });

  final double width;
  final String resource;
  final num amount;

  @override
  _DisplayHexState createState() => _DisplayHexState();
}

class _DisplayHexState extends State<DisplayHex> {
  bool _showGoldIcon = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: Stack(
        alignment: Alignment.center,
        children: [
          HexagonWidget.pointy(
            width: widget.width / 3.8,
            color: getTileColorByTileType(),
            elevation: 10,
            child: Center(
              child: Text(
                widget.amount.toString(),
                style: TextStyle(color: Colors.black, fontSize: widget.width / 15),
              ),
            ),
          ),
          if (_showGoldIcon)
            Center(
              child: IconButton(
                icon: Icon(Icons.attach_money, color: Colors.black38),
                onPressed: _buyGold,
              ),
            ),
        ],
      ),
    );
  }

  void _handleTap() {
    setState(() {
      _showGoldIcon = true;
    });
    Timer(Duration(seconds: 5), () {
      setState(() {
        _showGoldIcon = false;
      });
    });
  }

  void _buyGold() {
    if(widget.amount <1){
      return;
    }
    switch (widget.resource) {
      case "Wood":
        context.read<DataSource>().addGold(1,0,0,0);
      case "Sheep":
        context.read<DataSource>().addGold(0,0,0,1);
      case "Stone":
        context.read<DataSource>().addGold(0,1,0,0);
      case "Grain":
        context.read<DataSource>().addGold(0,0,1,0);
      default:
        context.read<DataSource>().addGold(0,0,0,0);
    }
    setState(() {
      _showGoldIcon = false;
    });
  }

  Color getTileColorByTileType() {
    switch (widget.resource) {
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
