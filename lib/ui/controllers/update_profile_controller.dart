import 'dart:convert';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_manager/data/models/user_model.dart';
import 'package:task_manager/data/network_caller/network_caller.dart';
import 'package:task_manager/data/network_caller/network_response.dart';
import 'package:task_manager/data/utility/urls.dart';
import 'package:task_manager/ui/controllers/authentication_controller.dart';

class UpdateProfileController extends GetxController {
  bool _updateProfileScreenInProgress = false;
  bool get updateProfileScreenInProgress => _updateProfileScreenInProgress;
  XFile? photo;


  Future<bool> updateProfile(
      String email, String firstname, String lastname, String mobile, String password) async {
    _updateProfileScreenInProgress = true;
    update();
    String? photoInBase64;
    Map<String, dynamic> inputData = {
      "email": email,
      "firstName": firstname,
      "lastName": lastname,
      "mobile": mobile,
    };
    if (password.isNotEmpty) {
      inputData["password"] = password;
    }

    if (photo != null) {
      List<int> imageBytes = await photo!.readAsBytes();
      photoInBase64 = base64Encode(imageBytes);
      inputData["photo"] = photoInBase64;
    }

    final NetworkResponse response =
        await NetworkCaller().postRequest(Urls.updateProfile, body: inputData);
    _updateProfileScreenInProgress = false;
    update();
    if (response.isSuccess) {
      Get.find<AuthenticationController>().updateUserInfo(
        UserModel(
            email: email,
            firstName: firstname,
            lastName: lastname,
            mobile: mobile,
            photo: photoInBase64 ??
                Get.find<AuthenticationController>().user?.photo),
      );
      return true;
    } else {
    }
    return false;
  }
}
