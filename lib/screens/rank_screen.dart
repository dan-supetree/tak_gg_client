import 'package:flutter/material.dart';

class RankScreen extends StatefulWidget {
  const RankScreen({super.key});

  @override
  State<RankScreen> createState() => _RankScreenState();
}

class _RankScreenState extends State<RankScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Ranking'),
        ),
        body: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              children: const [Text('Ranking')],
            )));
  }
}
