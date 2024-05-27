class Player {
  String wsId;
  String currentGameId;
  String playerName;
  num victoryPoints;
  num population;
  num ownedTileCount;
  num wood;
  num stone;
  num grain;
  num sheep;
  num gold;


  Player({
    required this.wsId,
    required this.currentGameId,
    required this.playerName,
    required this.victoryPoints,
    required this.population,
    required this.ownedTileCount,
    required this.wood,
    required this.stone,
    required this.grain,
    required this.sheep,
    required this.gold

  });

  factory Player.fromJson(Map<String, dynamic> json) {
    return Player(
        wsId: json['WsId'],
        currentGameId: json['CurrentGameId'],
        playerName: json['PlayerName'],
        victoryPoints: json['VictoryPoints'],
        population: json['Population'],
        ownedTileCount: json['OwnedTileCount'],
        wood: json['Wood'],
        stone: json['Stone'],
        grain: json['Grain'],
        sheep: json['Sheep'],
        gold: json['Gold']
    );
  }
}