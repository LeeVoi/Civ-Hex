using backend.WebSocket.Dto;
using Fleck;
using lib;

namespace backend.WebSocket.Event_Handler;

public class ServerBroadcastMessage : BaseEventHandler<ServerBroadcastMessageDto>
{
    public override Task Handle(ServerBroadcastMessageDto dto, IWebSocketConnection socket)
    {
        throw new NotImplementedException();
    }
}