import 'package:flutter/material.dart';
import 'package:tak_gg/screens/history_screen.dart';
import 'package:tak_gg/states/user_controller.dart';

class Rank extends StatelessWidget {
  const Rank({
    super.key,
    required this.userController,
    required this.rank,
    required this.name,
    required this.points,
    required this.profileImage,
  });

  final UserController userController;
  final String rank;
  final String name;
  final String profileImage;
  final num points;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => HistoryScreen(displayName: name)));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  rank,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  width: 12,
                ),
                CircleAvatar(
                    radius: 20, backgroundImage: NetworkImage(profileImage)),
                const SizedBox(
                  width: 12,
                ),
                Text(
                  name,
                  style: const TextStyle(fontSize: 18),
                ),
              ],
            ),
            Text(
              '$points.LP',
              style: const TextStyle(fontSize: 18),
            )
          ],
        ),
      ),
    );
  }
}
