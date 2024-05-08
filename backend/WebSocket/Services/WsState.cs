using System.Collections.Concurrent;
using backend.Models.states;
using backend.WebSocket.Services.Managers;
using Fleck;

namespace backend.WebSocket.Services;

public class WsState
{
    public static Dictionary<Guid, IWebSocketConnection> Connections = new();
    public static Dictionary<Guid, IWebSocketConnection> Queue = new();
    
    public static Dictionary<Guid, Guid> PlayersRooms = new();
    public static Dictionary<Guid, GameState> RoomsState = new();
    

    public static bool AddConnection(IWebSocketConnection ws)
    {
        return Connections.TryAdd(ws.ConnectionInfo.Id, ws);
    }

    public static void AddToQueue(IWebSocketConnection ws)
    {
        QueueManager.AddToQueue(ws, Queue);
    }

    public static void PurchaseTile(Guid roomId, Guid playerId, int rowIndex, int columnIndex)
    {
        PurchaseTileManager.PurchaseTile(roomId, playerId, rowIndex, columnIndex);
    }

    public static void EndTurn(Guid playerId, Guid roomId)
    {
        TurnManager.EndTurn(playerId, roomId);
    }

    public static void BuyGold(Guid roomId, Guid playerId, int wood, int stone, int grain, int sheep)
    {
        BuyGoldManager.BuyGold(roomId, playerId, wood, stone, grain, sheep);
    }

    public static void BuyPopulation(Guid roomId, Guid playerId, int wood, int stone, int grain, int sheep)
    {
        PopulationManager.BuyPopulation(roomId, playerId, wood, stone, grain, sheep);
    }
}