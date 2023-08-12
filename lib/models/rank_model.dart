class RankModel {
  final String rank;
  final String playerId;
  final String displayName;
  final String profileImage;
  final int ratingPoint;

  RankModel.fromJSON(Map<String, dynamic> json)
      : rank = json['rank'],
        playerId = json['playerId'],
        displayName = json['displayName'],
        profileImage = json['profileImage'],
        ratingPoint = json['ratingPoint'];
}
