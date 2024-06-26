namespace backend.Models.entities;

public class Player
{
    #region Properties

    public Guid WsId { get; set; }
    public Guid CurrentGameId { get; set; }
    public string PlayerName { get; set; }
    public int VictoryPoints { get; set; }
    public int Population { get; set; }
    public int OwnedTileCount { get; set; }
    public int Gold { get; set; }
    public int Wood { get; set; }
    public int Stone { get; set; }
    public int Grain { get; set; }
    public int Sheep { get; set; }

    #endregion
    
    



    public Player(string playerName, int gold, Guid wsId, Guid currentGameId)
    {
        PlayerName = playerName;
        Gold = gold;
        WsId = wsId;
        CurrentGameId = currentGameId;
    }


}