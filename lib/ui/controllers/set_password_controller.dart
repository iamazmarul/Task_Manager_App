import 'package:get/get.dart';
import 'package:task_manager/data/network_caller/network_caller.dart';
import 'package:task_manager/data/network_caller/network_response.dart';
import 'package:task_manager/data/utility/urls.dart';
import 'package:task_manager/ui/controllers/authentication_controller.dart';

class SetNewPasswordController extends GetxController {
  bool _setNewPasswordVerificationInProgress = false;
  String _snackMessage = "";

  bool get setNewPasswordVerificationInProgress =>
      _setNewPasswordVerificationInProgress;
  String get snackMessage => _snackMessage;

  Future<bool> setNewPassword(String password) async {
    _setNewPasswordVerificationInProgress = true;
    update();

    final saveEmail = await AuthenticationController.callEmail();
    final saveOtp = await AuthenticationController.callOTP();

    final NetworkResponse response =
        await NetworkCaller().postRequest(Urls.setNewPassword, body: {
      "email": saveEmail,
      "OTP": saveOtp,
      "password": password,
    });

    _setNewPasswordVerificationInProgress = false;
    update();

    if (response.isSuccess) {
      _snackMessage = "Forgot Password Successfully ";
      return true;
    } else {
      _snackMessage = "Forgot Password Failed! Please try again";
    }
    return false;
  }
}
