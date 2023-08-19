class PlayResult {
  final String playerId;
  final String displayName;
  final String profileImage;
  final int score;

  PlayResult.fromJSON(Map<String, dynamic> json)
      : playerId = json['playerId'],
        displayName = json['displayName'],
        profileImage = json['profileImage'],
        score = json['profileImage'];
}

class GameModel {
  final int gameId;
  final String status;
  final bool isWinner;
  final int ratingTransition;
  final PlayResult winner;
  final PlayResult loser;

  GameModel.fromJSON(Map<String, dynamic> json)
      : gameId = json['gameId'],
        status = json['status'],
        ratingTransition = json['ratingTransition'],
        isWinner = json['isWinner'],
        winner = json['winner'],
        loser = json['loser'];
}
