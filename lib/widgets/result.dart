import 'package:flutter/material.dart';
import 'package:tak_gg/models/game_model.dart';
import 'package:tak_gg/screens/history_screen.dart';

class Result extends StatelessWidget {
  const Result(
      {super.key,
      required this.winner,
      required this.loser,
      required this.playerId});

  final PlayResultModel winner;
  final PlayResultModel loser;
  final String playerId;

  @override
  Widget build(BuildContext context) {
    void handleTabWinner() {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>
                HistoryScreen(displayName: winner.displayName),
            settings: const RouteSettings(name: "/history"),
          ));
    }

    void handleTabLoser() {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HistoryScreen(displayName: loser.displayName),
            settings: const RouteSettings(name: "/history"),
          ));
    }

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: winner.playerId != playerId
            ? const Color(0xffFFF1F3)
            : const Color(0xffECF2FF),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: winner.playerId != playerId ? handleTabWinner : null,
              child: Row(
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
                          radius: 14,
                          backgroundImage: NetworkImage(winner.profileImage)),
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
                ],
              ),
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
            InkWell(
              onTap: loser.playerId != playerId ? handleTabLoser : null,
              child: Row(
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
                      radius: 14,
                      backgroundImage: NetworkImage(loser.profileImage)),
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
            ),
          ],
        ),
      ),
    );
  }
}
