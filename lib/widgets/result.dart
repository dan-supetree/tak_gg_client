import 'package:flutter/material.dart';
import 'package:tak_gg/models/game_model.dart';

class Result extends StatelessWidget {
  const Result({super.key, required this.winner, required this.loser});

  final PlayResultModel winner;
  final PlayResultModel loser;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [
            SizedBox(
              width: 60,
              child: Text(
                winner.displayName,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
            const SizedBox(
              width: 4,
            ),
            CircleAvatar(
                radius: 14, backgroundImage: NetworkImage(winner.profileImage)),
            const SizedBox(
              width: 12,
            ),
            SizedBox(
              width: 30,
              child: Center(
                child: Text(
                  winner.score.toString().padLeft(2, '0'),
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.red),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          width: 20,
        ),
        const Text(
          ':',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        const SizedBox(
          width: 20,
        ),
        Row(
          children: [
            SizedBox(
              width: 30,
              child: Center(
                child: Text(
                  loser.score.toString().padLeft(2, '0'),
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ),
            ),
            const SizedBox(
              width: 12,
            ),
            CircleAvatar(
                radius: 14, backgroundImage: NetworkImage(loser.profileImage)),
            const SizedBox(
              width: 4,
            ),
            SizedBox(
              width: 60,
              child: Text(
                loser.displayName,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
