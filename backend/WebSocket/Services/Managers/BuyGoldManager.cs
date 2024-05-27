using backend.Models.entities;
using backend.Models.states;

namespace backend.WebSocket.Services.Managers;

public static class BuyGoldManager
{

    public static void BuyGold(Guid roomId, Guid playerId,  int wood, int stone, int grain, int sheep)
    {

        GameState gameState = StateManager.FindGameStateByRoomId(roomId);
        Player player = StateManager.FindPlayerById(gameState, playerId);
        
        
        // Check if player have enough resources to sell
        if (player.Wood < wood || player.Stone < stone || player.Grain < grain || player.Sheep < sheep)
        {
            
            StateManager.UpdateRoomStateAndNotify(roomId, gameState);
            
        } else
        {
            // check if gameState && player is not null && it is the players turn
            if (gameState != null && player != null && StateManager.IsPlayersTurn(playerId, gameState))
            {
                // add the total amount of gold based on how many resources they want to sell
                int totalGold = wood + stone + grain + sheep;
                
                // Remove resources from player's inventory
                player.Wood -= wood;
                player.Stone -= stone;
                player.Grain -= grain;
                player.Sheep -= sheep;
                
                // Add the total amount of gold to the player's gold balance
                player.Gold += totalGold;
                
                // Update the game state and notify
                StateManager.UpdateRoomStateAndNotify(roomId, gameState);
            
            }
        }
    }
}