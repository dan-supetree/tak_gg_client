import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tak_gg/models/player_model.dart';
import 'package:tak_gg/services/api_service.dart';
import 'package:tak_gg/states/user_controller.dart';
import 'package:tak_gg/widgets/player_dropdown.dart';

class ResultSubmitScreen extends StatefulWidget {
  const ResultSubmitScreen({super.key});

  @override
  State<ResultSubmitScreen> createState() => _ResultSubmitScreenState();
}

class _ResultSubmitScreenState extends State<ResultSubmitScreen> {
  int step = 0;
  int player1Score = 0;
  int player2Score = 0;
  String? selected;
  List<PlayerModel> users = [];

  final UserController userController = Get.put(UserController());
  final TextEditingController textController1 = TextEditingController();
  final TextEditingController textController2 = TextEditingController();

  bool isDisabled() {
    if ((player1Score < 11 && player2Score < 11) || selected == null) {
      return true;
    }

    return false;
  }

  void fetchUserList() async {
    final List<PlayerModel> data = await ApiService.getPlayers();
    data.removeWhere((item) => item.displayName == userController.displayName);
    setState(() {
      users = data;
    });
  }

  void submitResult() async {
    if (selected == null) return;

    final data = [
      {
        'playerId': userController.playerId,
        'score': player1Score,
      },
      {
        'playerId': selected,
        'score': player2Score,
      }
    ];
    final result = await ApiService.postGameResult(data);

    if (result == true) {
      setState(() {
        player1Score = 0;
        player2Score = 0;
        step = 0;
        textController1.clear();
        textController2.clear();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: const Text(
            'Submit Success',
            style: TextStyle(fontSize: 18.0, color: Colors.white),
          ),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.green,
          margin: EdgeInsets.only(
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).size.height - 180,
          ),
        ));
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchUserList();
  }

  Widget controlsBuilder(context, details) {
    return step <= 1
        ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 1,
                child: ElevatedButton(
                    onPressed: step == 0 ? null : details.onStepCancel,
                    child: const Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Text('Back',
                          style: TextStyle(
                            fontSize: 18,
                          )),
                    )),
              ),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                flex: 1,
                child: ElevatedButton(
                    onPressed: details.onStepContinue,
                    child: const Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Text('Next',
                          style: TextStyle(
                            fontSize: 18,
                          )),
                    )),
              ),
            ],
          )
        : Row(
            children: [
              Expanded(
                flex: 1,
                child: ElevatedButton(
                  onPressed: details.onStepCancel,
                  child: const Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Text('Back',
                        style: TextStyle(
                          fontSize: 18,
                        )),
                  ),
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                flex: 1,
                child: ElevatedButton(
                    onPressed: player1Score < 11 ||
                            player2Score < 11 ||
                            selected == null
                        ? null
                        : () => showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title:
                                    const Center(child: Text('Are you Sure?')),
                                actions: [
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            submitResult();
                                            Navigator.of(context).pop();
                                          },
                                          child: const Padding(
                                            padding: EdgeInsets.all(12.0),
                                            child: Text('Confirm',
                                                style: TextStyle(
                                                  fontSize: 18,
                                                )),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Padding(
                                            padding: EdgeInsets.all(12.0),
                                            child: Text('Cancel',
                                                style: TextStyle(
                                                  fontSize: 18,
                                                )),
                                          ),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              );
                            }),
                    child: const Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Text('Submit',
                          style: TextStyle(
                            fontSize: 18,
                          )),
                    )),
              ),
            ],
          );
  }

  onTapStep(value) {
    setState(() {
      step = value;
    });
  }

  onContinueStep() {
    if (step < 2) {
      setState(() {
        step = step + 1;
      });
    }
  }

  onCancelStep() {
    if (step > 0) {
      setState(() {
        step = step - 1;
      });
    }
  }

  onChangeMyScore(value) {
    setState(() {
      player1Score = int.parse(value);
    });
  }

  onChangeOpponentScore(value) {
    setState(() {
      player2Score = int.parse(value);
    });
  }

  onSelectOpponent(value) {
    setState(() {
      selected = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
          appBar: AppBar(
            title: const Text(
              'Submit Game Result',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.blueGrey[900],
            iconTheme: const IconThemeData(color: Colors.white),
          ),
          body: Theme(
            data: ThemeData(
                colorScheme: Theme.of(context).colorScheme.copyWith(
                      primary: Colors.blueGrey[900],
                    )),
            child: Stepper(
              currentStep: step,
              type: StepperType.horizontal,
              onStepTapped: onTapStep,
              onStepContinue: onContinueStep,
              onStepCancel: onCancelStep,
              controlsBuilder: controlsBuilder,
              steps: [
                Step(
                    isActive: step >= 0,
                    state: step >= 0 ? StepState.complete : StepState.disabled,
                    title: const Text(''),
                    content: SizedBox(
                      height: height * 0.5,
                      child: Padding(
                          padding: const EdgeInsets.only(
                              top: 32.0, bottom: 32, left: 0, right: 0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'What is your score?',
                                style: TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(height: 20),
                              TextField(
                                controller: textController1,
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                decoration: const InputDecoration(
                                  labelText: 'Score',
                                  hintText: 'Enter your Score',
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10.0)),
                                    borderSide: BorderSide(
                                        width: 1, color: Colors.redAccent),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10.0)),
                                  ),
                                ),
                                onChanged: onChangeMyScore,
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              const Text(
                                  'Please check your score before submit',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  )),
                            ],
                          )),
                    )),
                Step(
                    isActive: step >= 1,
                    state: step >= 1 ? StepState.complete : StepState.disabled,
                    title: const Text(''),
                    content: SizedBox(
                      height: height * 0.5,
                      child: Padding(
                          padding: const EdgeInsets.only(
                              top: 32.0, bottom: 32, left: 0, right: 0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'What is opponent score?',
                                style: TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(height: 20),
                              TextField(
                                controller: textController2,
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                decoration: const InputDecoration(
                                  labelText: 'Score',
                                  hintText: 'Enter Score',
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10.0)),
                                    borderSide: BorderSide(
                                        width: 1, color: Colors.redAccent),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10.0)),
                                  ),
                                ),
                                onChanged: onChangeOpponentScore,
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              const Text(
                                  'Please check your score before submit',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  )),
                            ],
                          )),
                    )),
                Step(
                    isActive: step >= 2,
                    state: step >= 2 ? StepState.complete : StepState.disabled,
                    title: const Text(''),
                    content: SizedBox(
                      height: height * 0.5,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 32.0, bottom: 32, left: 0, right: 0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            PlayerDropdown(
                                selected: selected,
                                dropdownHandler: onSelectOpponent),
                            const SizedBox(
                              height: 20,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.black12,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text('You',
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w600)),
                                    SizedBox(width: 18),
                                    Text(' VS '),
                                    SizedBox(width: 18),
                                    Text('???',
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w600))
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  player1Score.toString().padLeft(2, '0'),
                                  style: const TextStyle(
                                      fontSize: 45,
                                      fontWeight: FontWeight.w600),
                                ),
                                const Text(' : ',
                                    style: TextStyle(fontSize: 40)),
                                Text(player2Score.toString().padLeft(2, '0'),
                                    style: const TextStyle(
                                        fontSize: 45,
                                        fontWeight: FontWeight.w600)),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ))
              ],
            ),
          )),
    );
  }
}
