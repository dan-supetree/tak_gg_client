import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tak_gg/models/player_model.dart';
import 'package:tak_gg/states/players_controller.dart';
import 'package:tak_gg/states/user_controller.dart';

class PlayerDropdown extends StatefulWidget {
  const PlayerDropdown(
      {super.key, required this.selected, required this.dropdownHandler});

  final Function(String?) dropdownHandler;
  final String? selected;

  @override
  State<PlayerDropdown> createState() => _PlayerDropdownState();
}

class _PlayerDropdownState extends State<PlayerDropdown> {
  final UserController userController = Get.put(UserController());
  final PlayerController playerController = Get.put(PlayerController());
  List<PlayerModel> users = [];

  void initUserList() {
    final List<PlayerModel> data = [...playerController.userList];
    final userName = userController.displayName;

    data.removeWhere((item) => item.displayName == userName);
    setState(() {
      users = [...data];
    });
  }

  @override
  void initState() {
    super.initState();
    initUserList();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.dropdownHandler(users[0].playerId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white, //background color of dropdown button
        border: Border.all(
            color: Colors.black38, width: 3), //border of dropdown button
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 12, right: 12, top: 4, bottom: 4),
        child: DropdownButton(
          value: widget.selected,
          items: users.map((user) {
            return DropdownMenuItem<String>(
                value: user.playerId,
                child: Text(user.displayName,
                    style: const TextStyle(
                      fontSize: 20,
                    )));
          }).toList(),
          onChanged: widget.dropdownHandler,
          isExpanded: true,
          underline: Container(),
        ),
      ),
    );
  }
}
