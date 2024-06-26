﻿using backend.Models.entities;
using backend.Models.enums;
using backend.Models.states;

namespace backend.Models.Helpers;

public static class GameStateHelper
{
    public static GameState NewGame(Guid roomId, Guid ws1Id, Guid ws2Id)
    {
        List<List<int>> numbers = new List<List<int>>
        {
            new List<int> {1, 2, 3, 4, 2, 1},
            new List<int> {6, 4, 5, 1, 3, 6},
            new List<int> {4, 3, 1, 4, 6, 3},
            new List<int> {5, 3, 5, 2, 1, 4},
            new List<int> {6, 2, 4, 6, 2, 5},
            new List<int> {3, 6, 1, 5, 3, 2}
        };

        List<List<TileType>> tileTypes = new List<List<TileType>>
        {
            new List<TileType> {TileType.Grain, TileType.Stone, TileType.Wood, TileType.Sheep, TileType.Grain, TileType.Stone},
            new List<TileType> {TileType.Sheep, TileType.Grain, TileType.Stone, TileType.Wood, TileType.Sheep, TileType.Wood},
            new List<TileType> {TileType.Wood, TileType.Stone, TileType.Grain, TileType.Stone ,TileType.Grain, TileType.Stone},
            new List<TileType> {TileType.Stone, TileType.Sheep, TileType.Sheep, TileType.Wood,TileType.Sheep, TileType.Wood},
            new List<TileType> {TileType.Stone, TileType.Wood, TileType.Grain, TileType.Grain, TileType.Stone, TileType.Grain},
            new List<TileType> {TileType.Grain, TileType.Wood, TileType.Sheep, TileType.Sheep, TileType.Wood, TileType.Sheep}
        };
        
        int startingGold = 10;
        int rowIndex = -1;
        int columnIndex = -1;
        List<List<HexTile>> hexList = new List<List<HexTile>>();

        foreach (var row in tileTypes)
        {
            var hexRow = new List<HexTile>();
            columnIndex = 0;
            rowIndex += 1;
            foreach (var tileType in row)
            {
                hexRow.Add(new HexTile(tileType, TileStatus.Unowned, numbers[hexList.Count][hexRow.Count], rowIndex, columnIndex));
                columnIndex += 1;
            }

            hexList.Add(hexRow);
        }

        
        List<Player> players = new List<Player>
        {
            new Player("player1", startingGold, ws1Id, roomId),
            new Player("player2", startingGold, ws2Id, roomId)
        };
        
        GameState state = new GameState(GameStatus.Active, players, hexList, 1, roomId);

        return state;
    }

    public static GameState Turn7Game(Guid roomId, Guid ws1Id, Guid ws2Id)
    {
        var gameState = NewGame(roomId, ws1Id, ws2Id);

        //Give player1 3 tiles in the top left
        gameState.HexTilesList[0][0].GetTileStatus = TileStatus.Owned;
        gameState.HexTilesList[0][0].Owner = gameState.PlayersList[0];
        
        gameState.HexTilesList[0][1].GetTileStatus = TileStatus.Owned;
        gameState.HexTilesList[0][1].Owner = gameState.PlayersList[0];
        
        gameState.HexTilesList[1][0].GetTileStatus = TileStatus.Owned;
        gameState.HexTilesList[1][0].Owner = gameState.PlayersList[0];
        
        //Give player2 3 tiles in the bottom right
        gameState.HexTilesList[5][5].GetTileStatus = TileStatus.Owned;
        gameState.HexTilesList[5][5].Owner = gameState.PlayersList[1];
        
        gameState.HexTilesList[5][4].GetTileStatus = TileStatus.Owned;
        gameState.HexTilesList[5][4].Owner = gameState.PlayersList[1];
        
        gameState.HexTilesList[4][5].GetTileStatus = TileStatus.Owned;
        gameState.HexTilesList[4][5].Owner = gameState.PlayersList[1];
        
        // Give each player one of each resource
        gameState.PlayersList[0].Wood = 5;
        gameState.PlayersList[0].Stone = 5;
        gameState.PlayersList[0].Grain = 5;
        gameState.PlayersList[0].Sheep = 5;
        gameState.PlayersList[0].Population = 24;

        gameState.PlayersList[1].Wood = 5;
        gameState.PlayersList[1].Stone = 5;
        gameState.PlayersList[1].Grain = 5;
        gameState.PlayersList[1].Sheep = 5;

        //Turn 7 means it's player1's turn
        gameState.TurnNumber = 7;

        return gameState;
    }
}