using backend.WebSocket.Dto;
using Fleck;
using lib;

namespace backend.WebSocket.Event_Handler;

public class ClientWantsPlayerId : BaseEventHandler<ClientWantsPlayerIdDto>
{
    public override Task Handle(ClientWantsPlayerIdDto dto, IWebSocketConnection socket)
    {
        var playerId = socket.ConnectionInfo.Id;
        var message = $"{{ \"PlayerId\": \"{playerId}\" }}";
        socket.Send(message);
        return Task.CompletedTask;
    }
}