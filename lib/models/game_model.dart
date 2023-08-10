class GamePlayer {
  final String playerId;
  final String displayName;
  final String profileImage;
  final int score;

  GamePlayer.fromJSON(Map<String, dynamic> json)
      : playerId = json['playerId'],
        displayName = json['displayName'],
        profileImage = json['profileImage'],
        score = json['profileImage'];
}

class GameModel {
  final int gameId;
  final String status;
  final int ratingTransition;
  final GamePlayer winner;
  final GamePlayer loser;

  GameModel.fromJSON(Map<String, dynamic> json)
      : gameId = json['gameId'],
        status = json['status'],
        ratingTransition = json['ratingTransition'],
        winner = json['winner'],
        loser = json['loser'];
}
