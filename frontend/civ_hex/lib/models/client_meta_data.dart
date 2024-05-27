class ClientMetaData {
  String _playerId;
  String _roomId;

  // Private constructor to prevent external instantiation
  ClientMetaData._({required String playerId, required String roomId})
      : _playerId = playerId,
        _roomId = roomId;

  // Singleton instance
  static ClientMetaData? _instance;

  // Factory method to create or return the existing instance
  factory ClientMetaData.getInstance({
    required String playerId,
    required String roomId,
  }) {
    _instance ??= ClientMetaData._(playerId: playerId, roomId: roomId);
    return _instance!;
  }


  String getPlayerId() => _playerId;

  String getRoomId() => _roomId;

  void setPlayerId(String playerId) {
    _playerId = playerId;
  }

  void setRoomId(String roomId) {
    _roomId = roomId;
  }
}