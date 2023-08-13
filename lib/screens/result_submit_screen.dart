import 'package:flutter/material.dart';
import 'package:flutter_material_pickers/flutter_material_pickers.dart';
import 'package:get/get.dart';
import 'package:tak_gg/models/player_model.dart';
import 'package:tak_gg/services/api_service.dart';
import 'package:tak_gg/states/user_controller.dart';

class ResultSubmitScreen extends StatefulWidget {
  const ResultSubmitScreen({super.key});

  @override
  State<ResultSubmitScreen> createState() => _ResultSubmitScreenState();
}

class _ResultSubmitScreenState extends State<ResultSubmitScreen> {
   final Future<List<PlayerModel>> players = ApiService.getPlayers();

  int player1Score = 0;
  int player2Score = 0;
  final UserController userController = Get.put(UserController());
  //Map<String,dynamic>? selectedUser;

  bool isDisabled() {
    if(player1Score < 11 && player2Score < 11) return true;

    return false;
  }

  void selectPlayer()async {
    print(players);
  }

  void submitResult() {
    print('submit');
  }

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
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                 Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        InkWell(
                         onTap: () {
                          showMaterialNumberPicker(
                            context: context, 
                            minNumber: 0, 
                            maxNumber: 50, 
                            title: 'Pick the Game Score',
                            selectedNumber: player1Score,
                            onChanged: (value) {
                              setState(() {
                                player1Score = value;
                              });
                            },
                            cancellable: false,
                          );
                         },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Text(player1Score.toString().padLeft(2,'0'),style: const TextStyle(
                              fontSize: 100,
                              fontWeight: FontWeight.w700
                            )),
                          ),
                        ),
                        const SizedBox(height: 12),
                         ElevatedButton(onPressed: null,child: Text(userController.displayName,style: const TextStyle(
                            fontSize:24,
                            fontWeight: FontWeight.w400,
                            color: Colors.black
                          )),
                        )
                      ],
                    ),
                     Column(
                      children: [
                        InkWell(
                          onTap: () {
                          showMaterialNumberPicker(
                            context: context, 
                            minNumber: 0, 
                            maxNumber: 50, 
                            title: 'Pick the Game Score',
                            selectedNumber: player2Score,
                            onChanged: (value) {
                              setState(() {
                                player2Score = value;
                              });
                            },
                            cancellable: false,
                          );
                         },
                          child: Text(player2Score.toString().padLeft(2,'0'),style: const TextStyle(
                            fontSize: 100,
                            fontWeight: FontWeight.w700
                          )),
                        ),
                        const SizedBox(height: 12),
                         ElevatedButton(onPressed: selectPlayer ,child: const Text('Player',style: TextStyle(
                            fontSize:24,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          )),
                        )
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                  ),
                  onPressed: isDisabled() ? null:submitResult,
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
