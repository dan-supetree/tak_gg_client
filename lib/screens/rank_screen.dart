import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tak_gg/states/UserController.dart';
import 'package:tak_gg/widgets/rank.dart';
import 'package:tak_gg/widgets/top_rank.dart';

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
                flex: 0,
                child: Container(
                  color: Colors.blue,
                  height: 300,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TopRank(
                            rank: 2,
                            name: 'nickName',
                            profileImage: userController.profileImage,
                            points: 1234
                          ),
                          TopRank(
                            rank: 1,
                            name: 'nickName',
                            profileImage: userController.profileImage,
                            points: 1234
                          ),
                          TopRank(
                            rank: 3,
                            name: 'nickName',
                            profileImage: userController.profileImage,
                            points: 1234
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30)),
                  child: Container(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 40, bottom: 60),
                      child: SingleChildScrollView(
                        child:Column(
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
                              Rank(
                                userController: userController,
                                rank: 6,
                                name: 'nickName',
                                points: 1234.5,
                              ),
                              Rank(
                                userController: userController,
                                rank:7,
                                name: 'nickName',
                                points: 1234.5,
                              ),
                              Rank(
                                userController: userController,
                                rank: 8,
                                name: 'nickName',
                                points: 1234.5,
                              ),
                              Rank(
                                userController: userController,
                                rank: 9,
                                name: 'nickName',
                                points: 1234.5,
                              ),
                              Rank(
                                userController: userController,
                                rank: 10,
                                name: 'nickName',
                                points: 1234.5,
                              ),
                              Rank(
                                userController: userController,
                                rank: 11,
                                name: 'nickName',
                                points: 1234.5,
                              ),
                              Rank(
                                userController: userController,
                                rank: 12,
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
                ),
              )
            ],
          ),
        ));
  }
}
