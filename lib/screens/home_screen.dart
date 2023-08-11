import 'package:flutter/material.dart';
import 'package:tak_gg/routes/slide_route.dart';
import 'package:tak_gg/screens/history_screen.dart';
import 'package:tak_gg/screens/profile_screen.dart';
import 'package:tak_gg/screens/rank_screen.dart';
import 'package:tak_gg/screens/result_submit_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            Ink(
              decoration: const ShapeDecoration(shape: CircleBorder()),
              child: IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      SlideRoute(
                          page: const ProfileScreen(), direction: 'left'));
                },
                icon: const Icon(Icons.account_circle),
                color: Colors.black,
                iconSize: 40,
              ),
            ),
          ],
        ),
        body: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Image(
                      image: AssetImage('assets/takgg_icon_rdbox.png'),
                      width: 200,
                      height: 200,
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size.fromHeight(50),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              SlideRoute(
                                  page: const ResultSubmitScreen(),
                                  direction: 'left'));
                        },
                        child: const Text('Submit Game Result',
                            style: TextStyle(
                              fontSize: 20,
                            ))),
                    const SizedBox(height: 16),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size.fromHeight(50),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              SlideRoute(
                                  page: const RankScreen(), direction: 'left'));
                        },
                        child: const Text('Ranking',
                            style: TextStyle(
                              fontSize: 20,
                            ))),
                    const SizedBox(height: 16),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size.fromHeight(50),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              SlideRoute(
                                  page: const HistoryScreen(),
                                  direction: 'left'));
                        },
                        child: const Text('Match History',
                            style: TextStyle(
                              fontSize: 20,
                            ))),
                  ],
                )
              ],
            )));
  }
}
