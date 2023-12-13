import 'package:get/get.dart';
import 'package:task_manager/data/network_caller/network_caller.dart';
import 'package:task_manager/data/network_caller/network_response.dart';
import 'package:task_manager/data/utility/urls.dart';
import 'package:task_manager/ui/controllers/authentication_controller.dart';
import 'package:task_manager/ui/screens/set_password_screen.dart';

class PinVerificationController extends GetxController {
  bool _pinVerificationInProgress = false;
  bool get pinVerificationInProgress => _pinVerificationInProgress;


  Future<bool> sendForgotPasswordRequest(String otp) async {
    _pinVerificationInProgress = true;
    update();
    final saveEmail = await AuthenticationController.callEmail();

    NetworkResponse response =
        await NetworkCaller().getRequest(Urls.getOTP(saveEmail, otp));
    _pinVerificationInProgress = false;
    update();
    if (response.jsonResponse?["status"] == "success") {
      await AuthenticationController.saveForgotPasswordOTP(otp);
      Get.to(const SetPasswordScreen());
      return true;
    } else {
      return false;
    }
  }
}
