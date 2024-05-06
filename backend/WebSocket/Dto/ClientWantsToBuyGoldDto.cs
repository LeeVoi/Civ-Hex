using lib;

namespace backend.WebSocket.Dto;

public class ClientWantsToBuyGoldDto : BaseDto
{
    public Guid roomId { get; set; }
    public Guid playerId { get; set; }
    public int wood { get; set; }
    public int stone { get; set; }
    public int grain { get; set; }
    public int sheep { get; set; }
}