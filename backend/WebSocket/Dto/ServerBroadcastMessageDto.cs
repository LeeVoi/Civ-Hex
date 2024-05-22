using lib;

namespace backend.WebSocket.Dto;

public class ServerBroadcastMessageDto : BaseDto
{ 
    public string message { get; set; }
}