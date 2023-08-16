import 'package:flutter/material.dart';

class TopRank extends StatelessWidget {
  const TopRank(
      {super.key,
      required this.rank,
      required this.name,
      required this.profileImage,
      required this.points});

  final String rank;
  final String name;
  final String profileImage;
  final int points;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Transform.translate(
          offset: const Offset(0, 8),
          child: Column(
            children: [
              CircleAvatar(
                  radius: 30, backgroundImage: NetworkImage(profileImage)),
              Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Column(
                    children: [
                      Text(name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                          )),
                      Text('$points.LP',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          )),
                    ],
                  )),
            ],
          ),
        ),
        Column(
          children: [
            Transform(
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.008)
                ..rotateX(-1),
              alignment: Alignment.bottomCenter,
              child: Container(
                color: rank == '1'
                    ? Colors.red
                    : rank == '2'
                        ? Colors.amber
                        : const Color.fromRGBO(133, 230, 197, 1),
                width: 100,
                height: 24,
              ),
            ),
            Container(
                color: rank == '1'
                    ? Colors.redAccent
                    : rank == '2'
                        ? Colors.amberAccent
                        : const Color.fromRGBO(152, 238, 204, 1),
                width: 100,
                height: rank == '1'
                    ? 140
                    : rank == '2'
                        ? 100
                        : 60,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(rank,
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                              fontSize: 28))
                    ])),
          ],
        )
      ],
    );
  }
}
