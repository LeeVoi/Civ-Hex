using backend.Models.states;
using backend.WebSocket.Dto;

namespace backend.WebSocket.Services.Managers;

public static class GameStateDtoManager
{

    public static ServerBroadcastGameStateDto GetGameStateDto(GameState state)
    {
        var dto = new ServerBroadcastGameStateDto
        {
            GameStatus = state.GameStatus,
            TurnNumber = state.TurnNumber,
            RoomId = state.RoomId,
            PlayersList = state.PlayersList,
            HexTilesList = state.HexTilesList
        };
        
        return dto;
    }
    
}