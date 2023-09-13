import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:tak_gg/models/player_model.dart';
import 'package:tak_gg/services/api_service.dart';
import 'package:tak_gg/states/players_controller.dart';
import 'package:tak_gg/states/user_controller.dart';
import 'package:tak_gg/widgets/play_results.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key, this.displayName});
  final String? displayName;

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
    final userName = widget.displayName ?? userController.displayName;

    PlayerModel user = data.firstWhere((item) => item.displayName == userName);
    data.removeWhere((item) => item.displayName == userName);
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
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Match History',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.blueGrey[900],
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
                    future: ApiService.getPlayer(selected),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final PlayerModel user = snapshot.data!;

                        return Column(
                          children: [
                            SizedBox(
                              height: 180,
                              child: UserInfo(
                                profileImage: user.profileImage,
                                displayName: user.displayName,
                                ratingPoint: user.ratingPoint ?? 0,
                                playStyle: user.style ?? 'None',
                                racket: user.racket ?? 'None',
                                rubberList:
                                    user.rubberList?.join('/') ?? 'None',
                                winCount: user.matchStat?.winCount ?? '0',
                                loseCount: user.matchStat?.loseCount ?? '0',
                                total: user.matchStat?.total ?? '0',
                              ),
                            ),
                            const SizedBox(height: 24),
                            SizedBox(
                                height: size.height * 0.45,
                                child: PlayResults(
                                    key: UniqueKey(), playerId: user.playerId))
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

class UserInfo extends StatelessWidget {
  const UserInfo({
    super.key,
    required this.profileImage,
    required this.displayName,
    required this.ratingPoint,
    required this.playStyle,
    required this.racket,
    required this.rubberList,
    required this.winCount,
    required this.loseCount,
    required this.total,
  });

  final String profileImage;
  final String displayName;
  final num? ratingPoint;
  final String playStyle;
  final String racket;
  final String rubberList;
  final String winCount;
  final String loseCount;
  final String total;

  @override
  Widget build(BuildContext context) {
    double rate = (double.parse(winCount) / double.parse(total)) * 100;
    final List<MatchData> chartData = winCount != '0' || loseCount != '0'
        ? [
            MatchData('win', double.parse(winCount),
                const Color.fromARGB(255, 167, 194, 252)),
            MatchData('lose', double.parse(loseCount),
                const Color.fromARGB(255, 255, 157, 172))
          ]
        : [
            MatchData('total', double.parse('1'),
                const Color.fromARGB(255, 207, 207, 207)),
            MatchData('empty', double.parse('0'),
                const Color.fromARGB(255, 207, 207, 207))
          ];

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                CircleAvatar(
                    radius: 35, backgroundImage: NetworkImage(profileImage)),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(displayName,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w800)),
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
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            Column(
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(
                        width: 100,
                        height: 80,
                        child: SfCircularChart(
                          margin: const EdgeInsets.all(0),
                          annotations: [
                            CircularChartAnnotation(
                                widget: SizedBox(
                                    width: 35,
                                    height: 35,
                                    child: PhysicalModel(
                                        shape: BoxShape.circle,
                                        elevation: 5,
                                        shadowColor: Colors.black,
                                        color: const Color.fromARGB(
                                            255, 255, 255, 255),
                                        child: Container()))),
                            CircularChartAnnotation(
                                widget: Text(
                                    '${rate.isNaN ? '0' : rate.toStringAsFixed(1)}%',
                                    style: const TextStyle(
                                        color: Color.fromRGBO(0, 0, 0, 1),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 9)))
                          ],
                          series: <CircularSeries>[
                            DoughnutSeries<MatchData, String>(
                              dataSource: chartData,
                              strokeWidth: 1,
                              animationDuration: 700,
                              strokeColor: Colors.white38,
                              pointColorMapper: (MatchData data, _) =>
                                  data.color,
                              xValueMapper: (MatchData data, _) => data.x,
                              yValueMapper: (MatchData data, _) => data.y,
                            )
                          ],
                        ),
                      ),
                    ]),
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
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.max,
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
                        SizedBox(
                          width: 120,
                          height: 28,
                          child: SelectableText(racket,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                              )),
                        ),
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
                        SizedBox(
                          width: 120,
                          height: 28,
                          child: SelectableText(rubberList,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.w700)),
                        ),
                      ])
                ],
              )),
        ),
      ],
    );
  }
}
