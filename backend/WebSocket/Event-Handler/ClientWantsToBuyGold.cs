using backend.WebSocket.Dto;
using backend.WebSocket.Services;
using Fleck;
using lib;

namespace backend.WebSocket.Event_Handler;

public class ClientWantsToBuyGold : BaseEventHandler<ClientWantsToBuyGoldDto>
{
    public override Task Handle(ClientWantsToBuyGoldDto dto, IWebSocketConnection socket)
    {
        WsState.BuyGold(dto.roomId, dto.playerId ,dto.wood, dto.stone, dto.grain, dto.sheep);
        return Task.CompletedTask;
    }
}