import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/ui/controllers/task_completed_controller.dart';
import 'package:task_manager/ui/widgets/profile_summary_card.dart';
import 'package:task_manager/ui/widgets/task_item_card.dart';

class TaskCompletedScreen extends StatefulWidget {
  const TaskCompletedScreen({super.key});

  @override
  State<TaskCompletedScreen> createState() => _TaskCompletedScreenState();
}

class _TaskCompletedScreenState extends State<TaskCompletedScreen> {

  final TaskCompletedController _taskCompletedController = Get.find<TaskCompletedController>();

  @override
  void initState() {
    super.initState();
    _taskCompletedController.getCompletedTaskList();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SafeArea(
        child: Column(
          children: [
            const ProfileSummaryCard(),
            Expanded(
              child: GetBuilder<TaskCompletedController>(
                builder: (taskCompletedController) {
                  return Visibility(
                    visible: taskCompletedController.getCompletedTaskInProgress == false,
                    replacement: const Center(child: CircularProgressIndicator()),
                    child: RefreshIndicator(
                      onRefresh: () async {
                        taskCompletedController.getCompletedTaskList();
                      },
                      child: ListView.builder(
                        itemCount: taskCompletedController.taskListModel.taskList?.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            child: ItemTaskCard(
                              task: taskCompletedController.taskListModel.taskList![index],
                              onStatusChange: (){taskCompletedController.getCompletedTaskList();},
                              showProgress: (inProgress){
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  );
                }
              ),
            ),
          ],
        ),
      ),
    );
  }
}
