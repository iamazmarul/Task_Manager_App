import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/ui/controllers/task_inprogress_controller.dart';
import 'package:task_manager/ui/widgets/profile_summary_card.dart';
import 'package:task_manager/ui/widgets/task_item_card.dart';

class TaskInprogressScreen extends StatefulWidget {
  const TaskInprogressScreen({super.key});

  @override
  State<TaskInprogressScreen> createState() => _TaskInprogressScreenState();
}

class _TaskInprogressScreenState extends State<TaskInprogressScreen> {
  final TaskInProgressController _taskInProgressController =
      Get.find<TaskInProgressController>();

  @override
  void initState() {
    super.initState();
    _taskInProgressController.getInProgressTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const ProfileSummaryCard(),
            Expanded(
              child: GetBuilder<TaskInProgressController>(
                  builder: (taskInProgressController) {
                return Visibility(
                  visible:
                      taskInProgressController.getInprogressTaskInProgress ==
                          false,
                  replacement: const Center(child: CircularProgressIndicator()),
                  child: RefreshIndicator(
                    onRefresh: () async {
                      taskInProgressController.getInProgressTaskList();
                    },
                    child: ListView.builder(
                      itemCount: taskInProgressController
                          .taskListModel.taskList?.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          child: ItemTaskCard(
                            task: taskInProgressController
                                .taskListModel.taskList![index],
                            onStatusChange: () {
                              taskInProgressController.getInProgressTaskList();
                            },
                            showProgress: (inProgress) {},
                          ),
                        );
                      },
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
