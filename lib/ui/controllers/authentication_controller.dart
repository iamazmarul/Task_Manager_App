import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager/data/models/user_model.dart';

class AuthenticationController {
  static String? token;
  static UserModel? user;

  static Future<void> saveUserInfo(String t, UserModel model) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString("token", t);
    await sharedPreferences.setString("user", jsonEncode(model.toJson()));
    token = t;
    user = model;
  }

  static Future<void> saveForgotPasswordEmail(String email) async{
    final sharedpreferences = await SharedPreferences.getInstance();
    await sharedpreferences.setString("ForgotPasswordEmail", email);
  }

  static Future<void> saveForgotPasswordOTP(String otp) async{
    final sharedpreferences = await SharedPreferences.getInstance();
    await sharedpreferences.setString("ForgotPasswordOTP", otp);
  }

  static Future<void> initilizedUserCache() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    token = sharedPreferences.getString("token");
    user = UserModel.fromJson(jsonDecode(sharedPreferences.getString("user") ?? "{}"));
  }

  static Future<String> callEmail() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString("ForgotPasswordEmail") ?? "";
  }

  static Future<String> callOTP() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString("ForgotPasswordOTP") ?? "";
  }

  static Future<bool> checkAuthState() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString("token");

    if (token != null) {
      await initilizedUserCache();
      return true;
    }
    return false;
  }

  static Future<void> clearAuthData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();
    token = null;
  }
}