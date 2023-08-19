import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/state_manager.dart';
import 'package:tak_gg/models/player_model.dart';

class PlayerController extends GetxController {
  List<PlayerModel> userList = [];

  void updateUsers(List<PlayerModel> data) {
    userList = data;
    update();
  }

  void resetUsers() {
    userList = [];
    update();
  }
}
