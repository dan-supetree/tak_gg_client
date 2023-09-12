import 'package:flutter/material.dart';
import 'package:tak_gg/models/game_model.dart';
import 'package:tak_gg/services/api_service.dart';
import 'package:tak_gg/widgets/result.dart';

class PlayResults extends StatefulWidget {
  final String playerId;
  const PlayResults({Key? key, required this.playerId}) : super(key: key);

  @override
  State<PlayResults> createState() => _PlayResultsState();
}

class _PlayResultsState extends State<PlayResults> {
  final ScrollController _scrollController = ScrollController();
  late List<GameModel> gameResults = [];

  bool _isLastPage = false;
  int _page = 1;
  bool _loading = true;

  void fetchData(int page) async {
    try {
      final String playerId = widget.playerId;
      final res = await ApiService.getMatchHistory(playerId, page);
      final List<GameModel> data = res['data'];

      _isLastPage = data.length >= int.parse(res['total']);
      gameResults = [...gameResults, ...data];
      _loading = false;
    } catch (e) {
      gameResults = [];
      _loading = false;
      _page = 1;
    } finally {
      if (mounted) {
        setState(() {});
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _isLastPage = false;
    _page = 1;
    gameResults = [];
    fetchData(_page);

    _scrollController.addListener(() {
      if (_scrollController.offset >=
              _scrollController.position.maxScrollExtent &&
          !_scrollController.position.outOfRange &&
          !_isLastPage) {
        _loading = true;
        _page += 1;
        fetchData(_page);
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_loading && _page == 1 && gameResults.isEmpty) {
      return const Center(
        child: Text('No Data'),
      );
    }

    return ListView.separated(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        controller: _scrollController,
        itemBuilder: (BuildContext context, int index) {
          if (_loading || gameResults.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return Result(
              playerId: widget.playerId,
              winner: gameResults[index].winner,
              loser: gameResults[index].loser);
        },
        separatorBuilder: (context, index) {
          return const SizedBox(height: 4);
        },
        itemCount: gameResults.length);
  }
}
