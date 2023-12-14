import 'package:get/get.dart';
import 'package:task_manager/data/models/task_summary_count_model.dart';
import 'package:task_manager/data/network_caller/network_caller.dart';
import 'package:task_manager/data/network_caller/network_response.dart';
import 'package:task_manager/data/utility/urls.dart';

class TaskSummaryCountController extends GetxController {
  bool _getTaskCountSummaryListProgress = false;
  TaskCountSummaryStatusModel _taskCountSummaryListModel =
      TaskCountSummaryStatusModel();

  bool get getTaskCountSummaryListProgress => _getTaskCountSummaryListProgress;

  TaskCountSummaryStatusModel get taskCountSummaryListModel =>
      _taskCountSummaryListModel;

  Future<bool> getTaskCountSummaryList() async {
    _getTaskCountSummaryListProgress = true;
    update();
    final NetworkResponse response =
        await NetworkCaller().getRequest(Urls.getTaskStatusCount);
    _getTaskCountSummaryListProgress = false;
    if (response.isSuccess) {
      _taskCountSummaryListModel =
          TaskCountSummaryStatusModel.fromJson(response.jsonResponse);
      update();
      return true;
    } else {
      update();
      return false;
    }
  }
}
