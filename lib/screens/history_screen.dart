import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tak_gg/models/player_model.dart';
import 'package:tak_gg/services/api_service.dart';
import 'package:tak_gg/states/players_controller.dart';
import 'package:tak_gg/states/user_controller.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final UserController userController = Get.put(UserController());
  final PlayerController playerController = Get.put(PlayerController());
  List<PlayerModel> users = [];
  String selected = '';

  void initUserList() {
    final List<PlayerModel> data = [...playerController.userList];
    PlayerModel user = data
        .firstWhere((item) => item.displayName == userController.displayName);
    data.removeWhere((item) => item.displayName == userController.displayName);
    setState(() {
      users = [user, ...data];
      selected = user.playerId;
    });
  }

  @override
  void initState() {
    super.initState();
    initUserList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Match History',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.blue,
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: Padding(
            padding: const EdgeInsets.only(
                top: 32.0, bottom: 32, left: 16, right: 16),
            child: Column(
              children: [
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.white, //background color of dropdown button
                    border: Border.all(
                        color: Colors.black38,
                        width: 3), //border of dropdown button
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 12, right: 12, top: 4, bottom: 4),
                    child: DropdownButton(
                      value: selected,
                      items: users.map((user) {
                        return DropdownMenuItem<String>(
                            value: user.playerId,
                            child: Text(user.displayName,
                                style: const TextStyle(
                                  fontSize: 20,
                                )));
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selected = value!;
                        });
                      },
                      isExpanded: true,
                      underline: Container(),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
                FutureBuilder(
                    future: Future.wait([
                      ApiService.getPlayer(selected),
                      //ApiService.getMatchHistory(selected, 1)
                    ]),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final PlayerModel user = snapshot.data![0];

                        return Column(
                          children: [
                            UserInfo(
                              profileImage: user.profileImage,
                              displayName: user.displayName,
                              ratingPoint: user.ratingPoint ?? 0,
                              playStyle: user.style ?? 'None',
                              racket: user.racket ?? 'None',
                              rubberList: user.rubberList?.join('/') ?? 'None',
                            ),
                            const SizedBox(height: 24),
                            Column(
                              children: [
                                GameResult(userController: userController),
                                const SizedBox(height: 24),
                                GameResult(userController: userController),
                                const SizedBox(height: 24),
                                GameResult(userController: userController),
                                const SizedBox(height: 24),
                                GameResult(userController: userController),
                                const SizedBox(height: 24),
                                GameResult(userController: userController),
                                const SizedBox(height: 24),
                                GameResult(userController: userController),
                                const SizedBox(height: 24),
                                GameResult(userController: userController),
                                const SizedBox(height: 24),
                                GameResult(userController: userController),
                              ],
                            )
                          ],
                        );
                      }

                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }),
              ],
            )));
  }
}

class GameResult extends StatelessWidget {
  const GameResult({
    super.key,
    required this.userController,
  });

  final UserController userController;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [
            const Text(
              'userName',
            ),
            const SizedBox(
              width: 4,
            ),
            CircleAvatar(
                radius: 14,
                backgroundImage: NetworkImage(userController.profileImage)),
            const SizedBox(
              width: 12,
            ),
            const Text(
              '11',
              style: TextStyle(
                  fontSize: 18, fontWeight: FontWeight.w500, color: Colors.red),
            ),
          ],
        ),
        const SizedBox(
          width: 20,
        ),
        const Text('End'),
        const SizedBox(
          width: 20,
        ),
        Row(
          children: [
            const Text(
              '8',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              width: 12,
            ),
            CircleAvatar(
                radius: 14,
                backgroundImage: NetworkImage(userController.profileImage)),
            const SizedBox(
              width: 4,
            ),
            const Text('userName'),
          ],
        ),
      ],
    );
  }
}

class UserInfo extends StatelessWidget {
  const UserInfo({
    super.key,
    required this.profileImage,
    required this.displayName,
    required this.ratingPoint,
    required this.playStyle,
    required this.racket,
    required this.rubberList,
  });

  final String profileImage;
  final String displayName;
  final num? ratingPoint;
  final String playStyle;
  final String racket;
  final String rubberList;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            CircleAvatar(
                radius: 40, backgroundImage: NetworkImage(profileImage)),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(displayName,
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.w800)),
                const SizedBox(height: 4),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Style: ',
                          style: TextStyle(
                            fontSize: 14,
                          )),
                      const SizedBox(
                        width: 4,
                      ),
                      Text(playStyle.toUpperCase(),
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          )),
                    ]),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Text('Points: ',
                        style: TextStyle(
                          fontSize: 14,
                        )),
                    Text(
                      '$ratingPoint.LP',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
        const SizedBox(height: 20),
        DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.black12, //background color of dropdown button
            //border of dropdown button
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Racket',
                            style: TextStyle(
                              fontSize: 18,
                            )),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(racket,
                            style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w700)),
                      ]),
                  Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Rubber',
                            style: TextStyle(
                              fontSize: 18,
                            )),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(rubberList,
                            style: const TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w700)),
                      ])
                ],
              )),
        ),
      ],
    );
  }
}
