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
          title: const Text(
            'Submit Game Result',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.blue,
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                  ),
                  onPressed: null,
                  child: const Text(
                    'Submit',
                    style: TextStyle(
                      fontSize: 20,
                    )
                  )
                ),
              ],
            )
        )
      );
  }
}
