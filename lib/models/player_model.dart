import 'package:flutter/material.dart';

class MatchData {
  MatchData(this.x, this.y, this.color);
  final String x;
  final double y;
  final Color color;
}

class MatchStatModel {
  final String total;
  final String winCount;
  final String loseCount;

  MatchStatModel.fromJSON(Map<String, dynamic> json)
      : total = json['total'],
        winCount = json['winCount'],
        loseCount = json['loseCount'];
}

class PlayerModel {
  final String playerId;
  final String displayName;
  final String profileImage;
  final String? racket;
  final List<dynamic>? rubberList;
  final num? ratingPoint;
  final String? style;
  final MatchStatModel? matchStat;

  PlayerModel.fromJSON(Map<String, dynamic> json)
      : playerId = json['playerId'],
        displayName = json['displayName'],
        profileImage = json['profileImage'],
        racket = json['racket'],
        style = json['style'],
        rubberList = json['rubberList'],
        ratingPoint = json['ratingPoint'] ?? 0,
        matchStat = MatchStatModel.fromJSON(json['matchStat'] ??
            {'total': '0', 'winCount': '0', 'loseCount': '0'});

  @override
  String toString() => displayName;
}
