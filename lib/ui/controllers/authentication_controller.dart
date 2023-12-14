import 'dart:convert';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager/data/models/user_model.dart';

class AuthenticationController extends GetxController{
  static String? token;
   UserModel? user;

  Future<void> saveUserInfo(String t, UserModel model) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString("token", t);
    await sharedPreferences.setString("user", jsonEncode(model.toJson()));
    token = t;
    user = model;
    update();
  }

  Future<void> updateUserInfo(UserModel model) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString("user", jsonEncode(model.toJson()));
    user = model;
    update();
  }

  Future<void> saveForgotPasswordEmail(String email) async{
    final sharedpreferences = await SharedPreferences.getInstance();
    await sharedpreferences.setString("ForgotPasswordEmail", email);
    update();
  }

  Future<void> saveForgotPasswordOTP(String otp) async{
    final sharedpreferences = await SharedPreferences.getInstance();
    await sharedpreferences.setString("ForgotPasswordOTP", otp);
    update();
  }

  Future<void> initilizedUserCache() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    token = sharedPreferences.getString("token");
    user = UserModel.fromJson(jsonDecode(sharedPreferences.getString("user") ?? "{}"));
    update();
  }

   Future<String> callEmail() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString("ForgotPasswordEmail") ?? "";
  }

  Future<String> callOTP() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString("ForgotPasswordOTP") ?? "";
  }

   Future<bool> checkAuthState() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    if (sharedPreferences.containsKey("token")) {
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