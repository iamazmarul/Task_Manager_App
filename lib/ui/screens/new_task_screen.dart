import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/data/models/task_count.dart';
import 'package:task_manager/ui/controllers/new_task_controller.dart';
import 'package:task_manager/ui/controllers/task_summary_count_controller.dart';
import 'package:task_manager/ui/screens/add_new_task_screen.dart';
import 'package:task_manager/ui/widgets/card_summary.dart';
import 'package:task_manager/ui/widgets/profile_summary_card.dart';
import 'package:task_manager/ui/widgets/task_item_card.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  final TaskSummaryCountController _taskSummaryCountController =
      Get.find<TaskSummaryCountController>();
  final NewTaskController _newTaskController = Get.find<NewTaskController>();

  @override
  void initState() {
    super.initState();
    _taskSummaryCountController.getTaskCountSummaryList();
    _newTaskController.getNewTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final response = await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const AddNewTaskScreen()));
          if (response != null && response == true) {
            _taskSummaryCountController.getTaskCountSummaryList();
            _newTaskController.getNewTaskList();
          }
        },
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const ProfileSummaryCard(),
            GetBuilder<TaskSummaryCountController>(
                builder: (TaskSummaryCountController) {
              return Visibility(
                  visible: TaskSummaryCountController
                              .getTaskCountSummaryListProgress ==
                          false &&
                      (TaskSummaryCountController.taskCountSummaryListModel
                              .taskCountList?.isNotEmpty ??
                          false),
                  replacement: const LinearProgressIndicator(),
                  child: SizedBox(
                    height: 100,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: TaskSummaryCountController
                                .taskCountSummaryListModel
                                .taskCountList
                                ?.length ??
                            0,
                        itemBuilder: (context, index) {
                          TaskCount taskCount = TaskSummaryCountController
                              .taskCountSummaryListModel.taskCountList![index];
                          return FittedBox(
                            child: CardSummary(
                              count: taskCount.sum.toString(),
                              title: taskCount.sId ?? '',
                            ),
                          );
                        }),
                  ));
            }),
            Expanded(
              child:
                  GetBuilder<NewTaskController>(builder: (NewTaskController) {
                return Visibility(
                  visible: NewTaskController.getNewTaskInProgress == false,
                  replacement: const Center(child: CircularProgressIndicator()),
                  child: RefreshIndicator(
                    onRefresh: () async {
                      NewTaskController.getNewTaskList();
                    },
                    child: ListView.builder(
                      itemCount:
                          NewTaskController.taskListModel.taskList?.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          child: ItemTaskCard(
                            task: NewTaskController
                                .taskListModel.taskList![index],
                            onStatusChange: () {
                              NewTaskController.getNewTaskList();
                              _taskSummaryCountController
                                  .getTaskCountSummaryList();
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
