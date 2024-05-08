using lib;

namespace backend.WebSocket.Dto;

public class ClientWantsToBuyPopulationDto : BaseDto
{
    public Guid roomId { get; set; }
    public Guid playerId { get; set; }
    public int population { get; set; }
    
}