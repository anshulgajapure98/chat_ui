import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  Future<void> saveUser(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("email", email);
    await prefs.setString("password", password);
  }

  Future<Map<String, String?>> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      "email": prefs.getString("email"),
      "password": prefs.getString("password"),
    };
  }

  Future<void> setLoggedIn(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("isLoggedIn", value);
  }
}