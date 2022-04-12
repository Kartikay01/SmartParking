/*import 'package:shared_preferences/shared_preferences.dart';
import 'package:parkingapp/models/user.dart' as user;

class UserSimplePreferences {
  static SharedPreferences _preferences =
      SharedPreferences.getInstance() as SharedPreferences;

  static Future init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static Future setStatus(bool yesorno) async {
    await _preferences.setBool('signedin', yesorno);
  }

  static Future setUser(user.User user) async {
    await _preferences.setString('uid', user.uid);
    await _preferences.setString('email', user.email);
    await _preferences.setString('carRegNumber', user.carRegNumber);
    await _preferences.setString('mobile', user.mobile);
  }

  static String getuid() => _preferences.getString('uid') ?? '';
  static String getEmail() => _preferences.getString('email') ?? '';
  static String getCarRegNumber() => _preferences.getString('carRegNo') ?? '';
  static bool getMobile() => _preferences.getBool('mobile') ?? false;
}
*/