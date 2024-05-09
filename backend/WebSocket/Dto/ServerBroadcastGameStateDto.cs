using backend.Models.entities;
using backend.Models.enums;
using backend.Models.states;
using lib;

namespace backend.WebSocket.Dto;

public class ServerBroadcastGameStateDto : BaseDto
{
    
    public GameStatus gameStatus { get; set; }
    
    public int turnNumber { get; set; }
    
    public Guid roomId { get; set; }
    
    public List<Player> playersList { get; set; }
    
    public List<List<HexTile>> hexTilesList { get; set; }
    
}