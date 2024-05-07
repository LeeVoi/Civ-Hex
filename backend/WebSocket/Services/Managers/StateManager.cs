using backend.Models;
using backend.Models.entities;
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
        NotifyPlayers(roomId, gameState);
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
                // Retrieve the player's connection using their Id and send the serialized game state
                WsState.Connections[connection.Key].Send(gameState.Serialize());
            }
        }
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