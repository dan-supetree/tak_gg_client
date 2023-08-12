import 'package:flutter/material.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Match History'),
        ),
        body: const Padding(
            padding: EdgeInsets.all(32.0),
            child: Column(
              children: [Text('Match History')],
            )));
  }
}
