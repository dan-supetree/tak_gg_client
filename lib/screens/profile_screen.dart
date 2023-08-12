import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tak_gg/states/user_controller.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final UserController userController = Get.put(UserController());

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              children: [
                Transform.scale(
                  scale: 2.5,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(100),
                        bottomRight: Radius.circular(100)),
                    child: Container(
                      width: 200,
                      height: 90,
                      color: Colors.blue,
                      child: Align(
                          alignment: Alignment.center,
                          child: Text(userController.displayName,
                              style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white))),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(userController.profileImage)),
                const SizedBox(height: 32),
                Column(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                        width: 1.0,
                        color: Colors.black12,
                      ))),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Racket',
                                style: TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.w600)),
                            Text(userController.racket ?? 'None')
                          ],
                        ),
                      ),
                    ),
                    Container(
                      decoration: const BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                        width: 1.0,
                        color: Colors.black12,
                      ))),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Rubber',
                                style: TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.w600)),
                            Text(userController.rubberList?.join(',') ?? 'None')
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Rating Point',
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.w600)),
                    Text('${userController.ratingPoint}.LP',
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500))
                  ],
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50),
                    ),
                    onPressed: null,
                    child: const Text('Submit'))
              ],
            )));
  }
}
