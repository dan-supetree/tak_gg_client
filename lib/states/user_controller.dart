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
    playerId = data['playerId'] ?? playerId;
    displayName = data['displayName'] ?? displayName;
    profileImage = data['profileImage'] ?? profileImage;
    racket = data['racket'] ?? racket;
    rubberList = data['rubberList'] ?? rubberList;
    ratingPoint = data['ratingPoint'] ?? ratingPoint;
    style = data['style'] ?? style;
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
