import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/state_manager.dart';

class UserController extends GetxController {
  bool active = false;
  String playerId = '';
  String displayName = '';
  String profileImage = '';
  String style = '';
  String? racket;
  List<String>? rubberList;
  num ratingPoint = 0;

  void updateUser(Map<String, dynamic> data) {
    playerId = data['playerId'];
    displayName = data['displayName'];
    profileImage = data['profileImage'];
    style = data['style'];
    racket = data['racket'];
    rubberList = data['rubberList'];
    ratingPoint = data['ratingPoint'];
    active = true;

    update();
  }

  void resetUser() {
    playerId = '';
    displayName = '';
    profileImage = '';
    style = '';
    racket = null;
    rubberList = null;
    ratingPoint = 0;
    active = false;

    update();
  }
}
