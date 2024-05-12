class Player {
  String wsId;
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
        wsId: json['wsId'],
        playerName: json['playerName'],
        victoryPoints: json['victoryPoints'],
        population: json['population'],
        ownedTileCount: json['ownedTileCount'],
        wood: json['wood'],
        stone: json['stone'],
        grain: json['grain'],
        sheep: json['sheep'],
        gold: json['gold']
    );
  }
}