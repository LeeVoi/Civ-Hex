using backend.Models;
using backend.Models.entities;
using backend.Models.enums;
using backend.Models.Helpers;
using backend.Models.states;

namespace backend.WebSocket.Services.Managers;

public static class StateManager
{
    public static Player FindPlayerById(GameState gameState, Guid playerId)
    {
        return gameState.PlayersList.FirstOrDefault(player => player.WsId == playerId);
    }
    
    public static GameState FindGameStateByRoomId(Guid roomId)
    {
        return WsState.RoomsState.ContainsKey(roomId) ? WsState.RoomsState[roomId] : null; 
    }
    
    public static bool IsPlayersTurn(Guid playerId, GameState gameState)
    {
        if (gameState.TurnNumber % 2 == 1 && gameState.PlayersList[0].WsId == playerId)
        {
            return true;
        }
        if (gameState.TurnNumber % 2 == 0 && gameState.PlayersList[1].WsId == playerId)
        {
            return true;
        }

        return false;

    }
    
    public static void UpdateRoomStateAndNotify(Guid roomId, GameState gameState)
    {
        WsState.RoomsState[roomId] = gameState;
        gameState = CalculateVictoryPoints(gameState);
        NotifyPlayers(roomId, gameState);
    }

    public static GameState CalculateVictoryPoints(GameState gamestate)
    {
        foreach (var player in gamestate.PlayersList)
        {
            player.VictoryPoints = player.OwnedTileCount + player.Population;
            player.VictoryPoints += (player.OwnedTileCount / 5) * 5;
            player.VictoryPoints += (player.Population / 5) * 5;
        }

        return gamestate;
    }
    
    // Method to notify players in a specific room about the updated game state
    private static void NotifyPlayers(Guid roomId, GameState gameState)
    {
        // Iterate through all player-room pairs in the WebSocket state
        foreach (var connection in WsState.PlayersRooms)
        {
            // Check if the room associated with the player's connection matches the specified roomId
            if (connection.Value == roomId)
            {
                if (IsGameComplete(gameState))
                {
                    EndGame(connection, roomId, gameState);
                    return;
                }
                // Retrieve the player's connection using their Id and send the serialized game state
                WsState.Connections[connection.Key].SendDto(GameStateDtoManager.GetGameStateDto(gameState));
            }
        }
    }

    private static bool IsGameComplete(GameState gameState)
    {
        if (gameState.PlayersList[0].VictoryPoints >= 50 || gameState.PlayersList[1].VictoryPoints >= 50)
        {
            gameState.GameStatus = GameStatus.Complete;
        }

        return gameState.GameStatus == GameStatus.Complete;
    }

    private static void EndGame(KeyValuePair<Guid, Guid> connection, Guid roomId, GameState gameState)
    {
        WsState.Connections[connection.Key].Send(FindWinningPlayer(gameState).PlayerName + " has won the game!");
        WsState.Connections[connection.Key].Send(gameState.Serialize());
        WsState.RoomsState.Remove(roomId);
        WsState.PlayersRooms.Remove(connection.Key);
    }

    private static Player FindWinningPlayer(GameState gameState)
    {
        foreach (var player in gameState.PlayersList)
        {
            if (player.VictoryPoints >= 50)
            {
                return player;
            }
        }

        return null;
    }
    
    // Method to send a notification to a specific player's connection
    public static void SendMessageToPlayer(Guid playerId, string message)
    {
        // Find the connection associated with the player
        if (WsState.Connections.TryGetValue(playerId, out var playerConnection))
        {
            // Send the notification message to the player's connection
            playerConnection.Send(message);
        }
    }
    
}