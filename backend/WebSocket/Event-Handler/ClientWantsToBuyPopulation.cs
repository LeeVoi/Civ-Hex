using backend.WebSocket.Dto;
using backend.WebSocket.Services;
using Fleck;
using lib;

namespace backend.WebSocket.Event_Handler;

public class ClientWantsToBuyPopulation : BaseEventHandler<ClientWantsToBuyPopulationDto>
{
    public override Task Handle(ClientWantsToBuyPopulationDto dto, IWebSocketConnection socket)
    {
        WsState.BuyPopulation(dto.roomId, dto.playerId, dto.population);
        return Task.CompletedTask;
    }
}