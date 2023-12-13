import 'package:get/get.dart';
import 'package:task_manager/data/network_caller/network_caller.dart';
import 'package:task_manager/data/network_caller/network_response.dart';
import 'package:task_manager/data/utility/urls.dart';
import 'package:task_manager/ui/controllers/authentication_controller.dart';

class ForgotPasswordController extends GetxController {
  bool _forgotPasswordEmailInProgress = false;
  String _snackMessage = "";

  bool get forgotPasswordEmailInProgress => _forgotPasswordEmailInProgress;
  String get snackMessage => _snackMessage;

  Future<bool> sendForgotPasswordRequest(String email) async {
    _forgotPasswordEmailInProgress = true;
    update();
    NetworkResponse response =
        await NetworkCaller().getRequest(Urls.getRecoveryEmail(email));
    _forgotPasswordEmailInProgress = false;
    update();

    if (response.isSuccess) {
      await AuthenticationController.saveForgotPasswordEmail(email);
      _snackMessage = "6 Digit OTP Sent to your Registered Email";
      return true;
    } else {
      _snackMessage =
          "Forgot password failed. Please enter your Registered Email ";
    }
    return false;
  }
}
