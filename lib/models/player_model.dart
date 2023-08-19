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
