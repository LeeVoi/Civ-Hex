using backend.WebSocket.Dto;
using Fleck;
using lib;

namespace backend.WebSocket.Event_Handler;

public class ServerBroadcastGameState : BaseEventHandler<ServerBroadcastGameStateDto>
{
    public override Task Handle(ServerBroadcastGameStateDto dto, IWebSocketConnection socket)
    {
        throw new NotImplementedException();
    }
}