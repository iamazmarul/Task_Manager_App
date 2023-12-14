import 'package:get/get.dart';
import 'package:task_manager/data/models/task_list_model.dart';
import 'package:task_manager/data/network_caller/network_caller.dart';
import 'package:task_manager/data/network_caller/network_response.dart';
import 'package:task_manager/data/utility/urls.dart';

class TaskInProgressController extends GetxController {
  bool _getInprogressTaskInProgress = false;
  TaskListModel _taskListModel = TaskListModel();

  bool get getInprogressTaskInProgress => _getInprogressTaskInProgress;
  TaskListModel get taskListModel => _taskListModel;

  Future<bool> getInProgressTaskList() async {
    _getInprogressTaskInProgress = true;
    update();
    final NetworkResponse response =
        await NetworkCaller().getRequest(Urls.getInProgressTask);
    _getInprogressTaskInProgress = false;
    if (response.isSuccess) {
      _taskListModel = TaskListModel.fromJson(response.jsonResponse);
      update();
      return true;
    } else {
      update();
      return false;
    }
  }
}
