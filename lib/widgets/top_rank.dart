import 'package:flutter/material.dart';

class TopRank extends StatelessWidget {
  const TopRank({
    super.key,
    required this.rank,
    required this.name,
    required this.profileImage,
    required this.points
  });

  final int rank;
  final String name;
  final String profileImage;
  final num points;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundImage: NetworkImage(
            profileImage
          )),
          const SizedBox(
            height: 4,
          ),
          Container(
            color: rank == 1 ? Colors.redAccent : rank == 2 ? Colors.amberAccent : Color.fromRGBO(152, 238, 204, 1),
            width: 100,
            height: rank == 1 ? 140 : rank == 2 ? 100 : 60,
          )
      ],
    );
  }
}