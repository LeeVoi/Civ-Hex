import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/player.dart';

class PlayerBoard extends StatefulWidget {
  Player player;

  PlayerBoard({super.key, required this.player});

  @override
  _PlayerBoardState createState() => _PlayerBoardState();
}

class _PlayerBoardState extends State<PlayerBoard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      color: Colors.blue,
    );
  }
}
