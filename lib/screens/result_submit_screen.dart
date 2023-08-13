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
  

  int player1Score = 0;
  int player2Score = 0;
  PlayerModel? selected;
  List<PlayerModel> users = [];
  final UserController userController = Get.put(UserController());
  

  bool isDisabled() {
    if((player1Score < 11 && player2Score < 11) || selected == null) return true;

    return false;
  }

  void selectPlayer() {
    showMaterialScrollPicker(context: context, items: users, selectedItem: selected,onChanged: (value) {      
      final user = users.firstWhere((item) => item.displayName == value?.displayName);
      setState(() {
        selected = user;
      });
    });
  }

  void fetchUserList()async {
     final List<PlayerModel> data = await ApiService.getPlayers();
     data.removeWhere((item) => item.displayName == userController.displayName);
     setState(() {
       users = data;
     });
  }

  void submitResult() {
    if(selected == null) return;

    final data = {
      'resultList': [{
        'playerId': userController.playerId,
        'score': player1Score,
      },{
        'playerId': selected?.playerId,
        'score': player2Score,
      }]
    };
    print(data);
  }

  @override
  void initState()  {
    // TODO: implement initState
    super.initState();
    fetchUserList();
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
                            fontSize:20,
                            fontWeight: FontWeight.w400,
                            color: Colors.black
                          )),
                        )
                      ],
                    ),
                    const SizedBox(width: 12),
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
                         ElevatedButton(onPressed: selectPlayer ,child:  Text(selected != null ? selected?.displayName ?? '' :'Player',style: const TextStyle(
                            fontSize:20,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
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
