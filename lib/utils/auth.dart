import 'package:shared_preferences/shared_preferences.dart';

Future<bool> checkIsAuthorized() async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.getString('accessToken');

    return true;
  } catch (e) {
    return false;
  }
}

Future<void> resetSession() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove('accessToken');
  prefs.remove('playerId');
}

Future<String> getPlayerId() async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final playerId = prefs.getString('playerId');
    return playerId as String;
  } catch (e) {
    return '';
  }
}
