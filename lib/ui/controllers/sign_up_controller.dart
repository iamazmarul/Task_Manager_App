import 'package:get/get.dart';
import 'package:task_manager/data/network_caller/network_caller.dart';
import 'package:task_manager/data/network_caller/network_response.dart';
import 'package:task_manager/data/utility/urls.dart';

class SignUpController extends GetxController{

  bool _signUpInProgress = false;
  String _failedMessage = "";

  bool get signUpInProgress => _signUpInProgress;
  String get failedMessage => _failedMessage;

  Future<bool> signUp(String email, String firstname, String lastname, String mobile, String password) async {
      _signUpInProgress = true;
      update();
      final NetworkResponse response =
      await NetworkCaller().postRequest(Urls.registration, body: {
        "email": email,
        "firstName": firstname,
        "lastName": lastname,
        "mobile": mobile,
        "password": password,
      });
      _signUpInProgress = false;
      update();
      if (response.isSuccess) {
        _failedMessage =  "Account has been Created! Please Log In";
        return true;
      } else {
        _failedMessage = "Account Creation Failed! Please try again";
      }
      return false;
  }
}