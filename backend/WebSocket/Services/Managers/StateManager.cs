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
        try
        {
            return gameState.PlayersList.FirstOrDefault(player => player.WsId == playerId)
                   ?? throw new ArgumentException($"Player with ID '{playerId}' not found.");
        }
        catch (Exception ex)
        {
            throw new Exception("Error occurred while trying to FindPlayerById.", ex);
        }
    }
    
    public static GameState FindGameStateByRoomId(Guid roomId)
    {
        try
        {
            return WsState.RoomsState.ContainsKey(roomId)
                ? WsState.RoomsState[roomId]
                : throw new ArgumentException($"Game state for room with ID '{roomId}' not found.");
        }
        catch (Exception ex)
        {
            throw new Exception("Error occurred in FindGameStateByRoomId.", ex);
        }
    }
    
    public static bool IsPlayersTurn(Guid playerId, GameState gameState)
    {
        try
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
        catch (Exception ex)
        {
            throw new Exception("Error occurred in IsPlayersTurn.", ex);
        }
        
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
        foreach (var roomConnection in WsState.PlayersRooms)
        {
            // Check if the room associated with the player's connection matches the specified roomId
            if (roomConnection.Value == roomId)
            {
                if (IsGameComplete(gameState))
                {
                    EndGame(roomConnection, roomId, gameState);
                }

                if (!IsGameComplete(gameState))
                {
                    // Retrieve the player's connection using their Id and send the serialized game state
                    WsState.Connections[roomConnection.Key].SendDto(GameStateDtoManager.GetGameStateDto(gameState));
                }
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
        var winningPlayer = FindWinningPlayer(gameState);

        // Retrieve the player's connection using their Id and send the serialized game state
        WsState.Connections[connection.Key].SendDto(GameStateDtoManager.GetGameStateDto(gameState));
        // Remove roomId and playersIds
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
    
    
}