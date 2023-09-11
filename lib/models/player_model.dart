class MatchStatModel {
  final int? total;
  final int? winCount;
  final int? loseCount;

  MatchStatModel.fromJSON(Map<String, dynamic> json)
      : total = json['total'] ?? 0,
        winCount = json['winCount'] ?? 0,
        loseCount = json['loseCount'] ?? 0;
}

class PlayerModel {
  final String playerId;
  final String displayName;
  final String profileImage;
  final String? racket;
  final List<dynamic>? rubberList;
  final num? ratingPoint;
  final String? style;

  PlayerModel.fromJSON(Map<String, dynamic> json)
      : playerId = json['playerId'],
        displayName = json['displayName'],
        profileImage = json['profileImage'],
        racket = json['racket'],
        style = json['style'],
        rubberList = json['rubberList'],
        ratingPoint = json['ratingPoint'] ?? 0;

  @override
  String toString() => displayName;
}
