import 'dart:async';

import 'package:civ_hex/enums/tile_status.dart';
import 'package:civ_hex/enums/tile_type.dart';
import 'package:civ_hex/models/client_meta_data.dart';
import 'package:civ_hex/models/data_source.dart';
import 'package:civ_hex/models/player.dart';
import 'package:flutter/material.dart';
import 'package:hexagon/hexagon.dart';
import 'package:provider/provider.dart';

class HexTile extends StatefulWidget {
  final TileType getTileType;
  final TileStatus getTileStatus;
  final int tileNumber;
  final Player? owner;
  final int row;
  final int column;

  HexTile({
    super.key,
    required this.getTileType,
    required this.getTileStatus,
    required this.tileNumber,
    required this.owner,
    required this.row,
    required this.column,
  });

  factory HexTile.fromJson(Map<String, dynamic> json) {
    return HexTile(
      getTileType: TileType.values[json['GetTileType']],
      getTileStatus: TileStatus.values[json['GetTileStatus']],
      tileNumber: json['TileNumber'],
      owner: json['Owner'] != null ? Player.fromJson(json['Owner']) : null,
      row: json['Row'],
      column: json['Column'],
    );
  }

  @override
  _HexTileState createState() => _HexTileState();
}

class _HexTileState extends State<HexTile> {
  bool _showShopIcon = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: Stack(
        alignment: Alignment.center,
        children: [
          HexagonWidget.pointy(
            width: 90,
            color: getTileColorByTileType(),
            elevation: 10,
            child: Text(
              widget.tileNumber.toString(),
              style: TextStyle(color: Colors.black),
            ),
          ),
          if (_showShopIcon)
            Center(
              child: IconButton(
                icon: Icon(
                  Icons.shopping_cart,
                  color: Colors.black38,
                ),
                onPressed: () {
                  context.read<DataSource>().buyTile(widget.row, widget.column);
                },
              ),
            ),
        ],
      ),
    );
  }

  void _handleTap() {
    setState(() {
      _showShopIcon = true;
    });
    Timer(Duration(seconds: 5), () {
      setState(() {
        _showShopIcon = false;
      });
    });
  }

  void _handleShopIconTap() {
    var message = {
      "eventType": "ClientWantsToPurchaseTile",
      "roomId": ClientMetaData.getInstance(playerId: '', roomId: '').getRoomId(),
      "playerId": ClientMetaData.getInstance(playerId: '', roomId: '').getPlayerId(),
      "rowIndex": widget.row,
      "columnIndex": widget.column
    };
    print(message); // Replace this line with your websocket send method
    setState(() {
      _showShopIcon = false;
    });
  }

  Color getTileColorByTileType() {
    switch (widget.getTileType) {
      case TileType.wood:
        return Colors.brown;
      case TileType.sheep:
        return Colors.green;
      case TileType.stone:
        return Colors.blueGrey;
      case TileType.grain:
        return Colors.yellow;
      default:
        return Colors.transparent;
    }
  }
}
