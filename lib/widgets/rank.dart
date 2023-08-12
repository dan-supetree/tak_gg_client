import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tak_gg/states/UserController.dart';

class Rank extends StatelessWidget {
  const Rank({
    super.key,
    required this.userController,
    required this.rank,
    required this.name,
    required this.points,
  });

  final UserController userController;
  final int rank;
  final String name;
  final num points;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                '$rank',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                width: 12,
              ),
              CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(userController.profileImage)),
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
    );
  }
}