import 'package:flutter/material.dart';
import 'package:tak_gg/services/api_service.dart';
import 'package:tak_gg/models/rank_model.dart';
import 'package:tak_gg/widgets/rank.dart';
import 'package:tak_gg/widgets/top_rank.dart';

class RankScreen extends StatefulWidget {
  const RankScreen({super.key});

  @override
  State<RankScreen> createState() => _RankScreenState();
}

class _RankScreenState extends State<RankScreen> {
  Future<List<RankModel>> ranks = ApiService.getRankList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Ranking',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.blueGrey[900],
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: RefreshIndicator(
          onRefresh: () {
            setState(() {
              ranks = ApiService.getRankList();
            });
            return Future<void>.value();
          },
          child: FutureBuilder(
            future: ranks,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final data = snapshot.data!;

                if (data.isEmpty) return const Text('Empty');

                final topRanks = data.sublist(0, 3);
                final etcRanks = data.sublist(3);

                return Container(
                  color: Colors.blueGrey[800],
                  child: Column(
                    children: [
                      Flexible(
                        flex: 0,
                        child: Container(
                          color: Colors.blueGrey[800],
                          height: 300,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TopRankList(topRanks: topRanks),
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
                              padding:
                                  const EdgeInsets.only(top: 40, bottom: 60),
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    RankList(
                                      etcRanks: etcRanks,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ));
  }
}

class TopRankList extends StatelessWidget {
  const TopRankList({
    super.key,
    required this.topRanks,
  });

  final List<RankModel> topRanks;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        TopRank(
          rank: topRanks[1].rank,
          name: topRanks[1].displayName,
          profileImage: topRanks[1].profileImage,
          points: topRanks[1].ratingPoint,
        ),
        TopRank(
          rank: topRanks[0].rank,
          name: topRanks[0].displayName,
          profileImage: topRanks[0].profileImage,
          points: topRanks[0].ratingPoint,
        ),
        TopRank(
          rank: topRanks[2].rank,
          name: topRanks[2].displayName,
          profileImage: topRanks[2].profileImage,
          points: topRanks[2].ratingPoint,
        ),
      ],
    );
  }
}

class RankList extends StatelessWidget {
  const RankList({
    super.key,
    required this.etcRanks,
  });

  final List<RankModel> etcRanks;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      primary: false,
      itemCount: etcRanks.length,
      itemBuilder: (context, index) => Rank(
        rank: etcRanks[index].rank,
        name: etcRanks[index].displayName,
        points: etcRanks[index].ratingPoint,
        profileImage: etcRanks[index].profileImage,
      ),
    );
  }
}
