using backend.Models.entities;
using backend.Models.enums;
using backend.Models.states;
using lib;

namespace backend.WebSocket.Dto;

public class ServerBroadcastGameStateDto : BaseDto
{
    
    public GameStatus GameStatus { get; set; }
    
    public int TurnNumber { get; set; }
    
    public Guid RoomId { get; set; }
    
    public List<Player> PlayersList { get; set; }
    
    public List<List<HexTile>> HexTilesList { get; set; }
    
}