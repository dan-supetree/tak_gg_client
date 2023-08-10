import 'package:flutter/material.dart';

class ResultSubmitScreen extends StatefulWidget {
  const ResultSubmitScreen({super.key});

  @override
  State<ResultSubmitScreen> createState() => _ResultSubmitScreenState();
}

class _ResultSubmitScreenState extends State<ResultSubmitScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Submit Game Result'),
        ),
        body: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              children: const [Text('Submit')],
            )));
  }
}
