class PlayResultModel {
  final String playerId;
  final String displayName;
  final String profileImage;
  final int score;

  PlayResultModel.fromJSON(Map<String, dynamic> json)
      : playerId = json['playerId'],
        displayName = json['displayName'],
        profileImage = json['profileImage'],
        score = json['score'];
}

class GameModel {
  final int gameId;
  final String status;
  final bool isWinner;
  final int ratingTransition;
  final PlayResultModel winner;
  final PlayResultModel loser;

  GameModel.fromJSON(Map<String, dynamic> json)
      : gameId = json['gameId'],
        status = json['status'],
        ratingTransition = json['ratingTransition'],
        isWinner = json['isWinner'],
        winner = PlayResultModel.fromJSON(json['winner']),
        loser = PlayResultModel.fromJSON(json['loser']);
}
