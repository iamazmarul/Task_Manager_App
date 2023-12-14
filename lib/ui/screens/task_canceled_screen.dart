import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/ui/controllers/task_cancelled_controller.dart';
import 'package:task_manager/ui/widgets/profile_summary_card.dart';
import 'package:task_manager/ui/widgets/task_item_card.dart';

class TaskCanceledScreen extends StatefulWidget {
  const TaskCanceledScreen({super.key});

  @override
  State<TaskCanceledScreen> createState() => _TaskCanceledScreenState();
}

class _TaskCanceledScreenState extends State<TaskCanceledScreen> {

  final TaskCancelledController _taskCancelledController = Get.find<TaskCancelledController>();

  @override
  void initState() {
    super.initState();
    _taskCancelledController.getCancelledTaskList();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SafeArea(
        child: Column(
          children: [
            const ProfileSummaryCard(),
            Expanded(
              child: GetBuilder<TaskCancelledController>(
                builder: (taskCancelledController) {
                  return Visibility(
                    visible: taskCancelledController.getCancelledTaskInProgress == false,
                    replacement: const Center(child: CircularProgressIndicator()),
                    child: RefreshIndicator(
                      onRefresh: () async {
                        taskCancelledController.getCancelledTaskList();
                      },
                      child: ListView.builder(
                        itemCount: taskCancelledController.taskListModel.taskList?.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            child: ItemTaskCard(
                              task: taskCancelledController.taskListModel.taskList![index],
                              onStatusChange: (){taskCancelledController.getCancelledTaskList();},
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
