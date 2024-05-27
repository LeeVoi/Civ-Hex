using backend.Models.enums;

namespace backend.Models.entities;
    
public class HexTile
{
    #region properties

    public TileType GetTileType { get; set; }
    
    public TileStatus GetTileStatus { get; set; }
        
    public int TileNumber { get; set; }
        
    public Player? Owner { get; set; }
    
    public int Row { get; set; }
    
    public int Column { get; set; }
    

    #endregion
    

    public HexTile(TileType tileType, TileStatus tileStatus, int tileNumber, int row, int column)
    {
        GetTileType = tileType;
        GetTileStatus = tileStatus;
        TileNumber = tileNumber;
        Owner = null;
        Row = row;
        Column = column;
    }
    
    
    
}