﻿using backend.Models.entities;
using backend.Models.states;

namespace backend.WebSocket.Services.Managers;

public static class PopulationManager
{
    public static void BuyPopulation(Guid roomId, Guid playerId, int population)
    {
        GameState gameState = StateManager.FindGameStateByRoomId(roomId);
        Player player = StateManager.FindPlayerById(gameState, playerId);
        
        if (StateManager.IsPlayersTurn(playerId, gameState))
        {
            if (player.Wood < population || player.Stone < population || player.Grain < population || player.Sheep < population)
            {
              StateManager.UpdateRoomStateAndNotify(roomId, gameState);
              return;
            }

            player.Population += population;
            player.Wood -= population;
            player.Stone -= population;
            player.Grain -= population;
            player.Sheep -= population;
            StateManager.UpdateRoomStateAndNotify(roomId, gameState);
        }    
    }
}