﻿using System.Collections.Concurrent;
using backend.Models.Helpers;
using backend.Models.states;
using backend.WebSocket.Dto;
using Fleck;

namespace backend.WebSocket.Services.Managers;

public class QueueManager
{

    public static void AddToQueue(IWebSocketConnection ws, Dictionary<Guid, IWebSocketConnection> queue)
    {
        WsState.AddConnection(ws);
        queue.TryAdd(ws.ConnectionInfo.Id, ws);
        CheckForNewGame(queue);
    }

    public static void CheckForNewGame(Dictionary<Guid, IWebSocketConnection> queue)
    {
        while (queue.Count >= 2)
        {
            var player1 = queue.First().Key;
            var player2 = queue.Skip(1).First().Key;
            
            AddPlayersToRooms(queue[player1] ,queue[player2]);
            
            queue.Remove(player1, out _);
            queue.Remove(player2, out _);
        }
    }

    private static void AddPlayersToRooms(IWebSocketConnection ws1, IWebSocketConnection ws2)
    {
        var roomId = Guid.NewGuid();
        GameState state = GameStateHelper.NewGame(roomId, ws1.ConnectionInfo.Id, ws2.ConnectionInfo.Id);
        
        WsState.RoomsState.TryAdd(roomId, state);
        WsState.PlayersRooms.TryAdd(ws1.ConnectionInfo.Id, roomId);
        WsState.PlayersRooms.TryAdd( ws2.ConnectionInfo.Id, roomId);
        

        foreach (var id in WsState.PlayersRooms)
        {
            if (roomId == id.Value)
            {
                Console.WriteLine("Client added to room");
                WsState.Queue[id.Key].SendDto(GameStateDtoManager.GetGameStateDto(state));
            }
        }
    }
}