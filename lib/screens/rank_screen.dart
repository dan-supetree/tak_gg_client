import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tak_gg/states/UserController.dart';

class RankScreen extends StatefulWidget {
  const RankScreen({super.key});

  @override
  State<RankScreen> createState() => _RankScreenState();
}

class _RankScreenState extends State<RankScreen> {
  @override
  Widget build(BuildContext context) {
    final UserController userController = Get.put(UserController());

    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Ranking',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.blue,
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: Container(
          color: Colors.blue,
          child: Column(
            children: [
              Flexible(
                flex: 1,
                child: Container(
                  color: Colors.transparent,
                  height: 400,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              CircleAvatar(
                                  radius: 30,
                                  backgroundImage: NetworkImage(
                                      userController.profileImage)),
                              const SizedBox(
                                height: 4,
                              ),
                              Container(
                                color: Colors.amberAccent,
                                width: 100,
                                height: 100,
                              )
                            ],
                          ),
                          Column(
                            children: [
                              CircleAvatar(
                                  radius: 30,
                                  backgroundImage: NetworkImage(
                                      userController.profileImage)),
                              const SizedBox(
                                height: 4,
                              ),
                              Container(
                                color: Colors.redAccent,
                                width: 100,
                                height: 140,
                              )
                            ],
                          ),
                          Column(
                            children: [
                              CircleAvatar(
                                  radius: 30,
                                  backgroundImage: NetworkImage(
                                      userController.profileImage)),
                              const SizedBox(
                                height: 4,
                              ),
                              Container(
                                color: const Color.fromRGBO(152, 238, 204, 1),
                                width: 100,
                                height: 60,
                              )
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Flexible(
                flex: 2,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30)),
                  child: Container(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 32, bottom: 40),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Rank(
                                userController: userController,
                                rank: 4,
                                name: 'nickName',
                                points: 1234.5,
                              ),
                              Rank(
                                userController: userController,
                                rank: 5,
                                name: 'nickName',
                                points: 1234.5,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}

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
                  radius: 25,
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
