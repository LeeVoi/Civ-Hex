using backend.Models.states;
using backend.WebSocket.Dto;

namespace backend.WebSocket.Services.Managers;

public static class GameStateDtoManager
{

    public static ServerBroadcastGameStateDto GetGameStateDto(GameState state)
    {
        var dto = new ServerBroadcastGameStateDto
        {
            gameStatus = state.GameStatus,
            turnNumber = state.TurnNumber,
            roomId = state.RoomId,
            playersList = state.PlayersList,
            hexTilesList = state.HexTilesList
        };
        
        return dto;
    }
    
}