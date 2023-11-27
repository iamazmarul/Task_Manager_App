import 'package:flutter/material.dart';
import 'package:task_manager/data/models/task_list_model.dart';
import 'package:task_manager/data/network_caller/network_caller.dart';
import 'package:task_manager/data/network_caller/network_response.dart';
import 'package:task_manager/data/utility/urls.dart';
import 'package:task_manager/ui/widgets/profile_summary_card.dart';
import 'package:task_manager/ui/widgets/task_item_card.dart';

class TaskInprogressScreen extends StatefulWidget {
  const TaskInprogressScreen({super.key});

  @override
  State<TaskInprogressScreen> createState() => _TaskInprogressScreenState();
}

class _TaskInprogressScreenState extends State<TaskInprogressScreen> {

  bool getInprogressTaskInProgress = false;
  TaskListModel taskListModel = TaskListModel();

  Future<void> getInProgressTaskList() async {
    getInprogressTaskInProgress = true;
    if (mounted) {
      setState(() {});
    }
    final NetworkResponse response =
        await NetworkCaller().getRequest(Urls.getInProgressTask);
    if (response.isSuccess) {
      taskListModel = TaskListModel.fromJson(response.jsonResponse);
    }
    getInprogressTaskInProgress = false;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    getInProgressTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const ProfileSummaryCard(),
            Expanded(
              child: Visibility(
                visible: getInprogressTaskInProgress == false,
                replacement: const Center(child: CircularProgressIndicator()),
                child: ListView.builder(
                  itemCount: taskListModel.taskList?.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: ItemTaskCard(
                        task: taskListModel.taskList![index],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
