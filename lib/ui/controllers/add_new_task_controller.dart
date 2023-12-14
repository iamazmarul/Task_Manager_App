import 'package:get/get.dart';
import 'package:task_manager/data/network_caller/network_caller.dart';
import 'package:task_manager/data/network_caller/network_response.dart';
import 'package:task_manager/data/utility/urls.dart';

class AddNewTaskController extends GetxController{

bool  _createTaskinprogress = false;
String _snackMessage = "";
bool get createTaskinprogress => _createTaskinprogress;
String get snackMessage => _snackMessage;

  Future<bool> createNewTask(String subject, String description) async {
      _createTaskinprogress = true;
      update();
      final NetworkResponse response =
      await NetworkCaller().postRequest(Urls.createNewTask, body: {
        "title": subject,
        "description": description,
        "status": "New"
      });
      _createTaskinprogress = false;
      update();
      if(response.isSuccess){
        _snackMessage = "Create new task successfully";
        return true;
      } else{
        _snackMessage = "Create new task failed! Try again";
      }
      return false;
    }
  }
