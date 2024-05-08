using backend.Models.entities;
using backend.Models.states;

namespace backend.WebSocket.Services.Managers;

public static class PopulationManager
{
    public static void BuyPopulation(Guid roomId, Guid playerId, int wood, int stone, int grain, int sheep)
    {
        GameState gameState = StateManager.FindGameStateByRoomId(roomId);
        Player player = StateManager.FindPlayerById(gameState, playerId);

        while (StateManager.IsPlayersTurn(playerId, gameState) && wood >= 1 && stone >= 1 && grain >= 1 && sheep >= 1)
        {
            player.Population += 1;
            player.Wood -= 1;
            player.Stone -= 1;
            player.Grain -= 1;
            player.Sheep -= 1;

            wood -= 1;
            stone -= 1;
            grain -= 1;
            sheep -= 1;
        }
        StateManager.UpdateRoomStateAndNotify(roomId, gameState);
    }
}