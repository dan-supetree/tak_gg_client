import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tak_gg/screens/home_screen.dart';
import 'package:tak_gg/services/api_service.dart';
import 'package:tak_gg/states/user_controller.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  String token = '';

  @override
  Widget build(BuildContext context) {
    final UserController userController = Get.put(UserController());

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.only(top: 32.0, left: 32, right: 32, bottom: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Image(
                image: AssetImage('assets/takgg_icon_rdbox.png'),
                width: 200,
                height: 200,
              ),
              const SizedBox(height: 32),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Token',
                  hintText: 'Enter your token',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(width: 1, color: Colors.redAccent),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    token = value;
                  });
                },
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                    shape: const StadiumBorder(),
                    padding: const EdgeInsets.all(20),
                  ),
                  onPressed: token == ''
                      ? null
                      : () async {
                          try {
                            final player =
                                await ApiService.postAuthRequest(token);

                            if (!mounted) return;

                            userController.updateUser({
                              "playerId": player.playerId,
                              "profileImage": player.profileImage,
                              "displayName": player.displayName,
                              "racket": player.racket,
                              "rubberList":
                                  List<String>.from(player.rubberList ?? []),
                              "ratingPoint": player.ratingPoint,
                              "style": player.style
                            });

                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    settings:
                                        const RouteSettings(name: '/home'),
                                    builder: (context) => const HomeScreen()));
                          } catch (e) {
                            print('error:$e');
                          }
                        },
                  child: const Text(
                    'Continue',
                    style: TextStyle(fontSize: 20),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
