import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/ui/controllers/add_new_task_controller.dart';
import 'package:task_manager/ui/controllers/new_task_controller.dart';
import 'package:task_manager/ui/controllers/task_summary_count_controller.dart';
import 'package:task_manager/ui/widgets/body_background.dart';
import 'package:task_manager/ui/widgets/profile_summary_card.dart';
import 'package:task_manager/ui/widgets/show_snack_message.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key});

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  final TextEditingController _subjectTEController = TextEditingController();
  final TextEditingController _descriptionTEController =
      TextEditingController();
  final AddNewTaskController _addNewTaskController =
  Get.find<AddNewTaskController>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        return false;
      },
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              const ProfileSummaryCard(),
              Expanded(
                  child: BodyBackground(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 32.0,
                          ),
                          Text(
                            "Add New Task",
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          TextFormField(
                              controller: _subjectTEController,
                              decoration:
                                  const InputDecoration(hintText: "Subject"),
                              validator: (String? value) {
                                if (value?.trim().isEmpty ?? true) {
                                  return "Enter your Subject";
                                }
                                return null;
                              }),
                          const SizedBox(
                            height: 8,
                          ),
                          TextFormField(
                              controller: _descriptionTEController,
                              maxLines: 5,
                              decoration: const InputDecoration(
                                  hintText: "Description"),
                              validator: (String? value) {
                                if (value?.trim().isEmpty ?? true) {
                                  return "Enter your Description";
                                }
                                return null;
                              }),
                          const SizedBox(
                            height: 16.0,
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: GetBuilder<AddNewTaskController>(
                                builder: (AddNewTaskController) {
                              return Visibility(
                                visible:
                                    _addNewTaskController.createTaskinprogress ==
                                        false,
                                replacement: const Center(
                                  child: CircularProgressIndicator(),
                                ),
                                child: ElevatedButton(
                                  onPressed: () {
                                    createNewTask();
                                  },
                                  child: const Icon(
                                      Icons.arrow_circle_right_outlined),
                                ),
                              );
                            }),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }

  Future<void> createNewTask() async {
    if (_formKey.currentState!.validate()) {
      final response = await _addNewTaskController.createNewTask(
          _subjectTEController.text.trim(),
          _descriptionTEController.text.trim());
      if (response) {
        _subjectTEController.clear();
        _descriptionTEController.clear();
        Get.find<NewTaskController>().getNewTaskList();
        Get.find<TaskSummaryCountController>().getTaskCountSummaryList();
        if (mounted) {
          showSnackMessage(
            context,
            _addNewTaskController.snackMessage,
          );
        }
      } else {
        if (mounted) {
          showSnackMessage(context, _addNewTaskController.snackMessage, true);
        }
      }
    }
  }

  @override
  void dispose() {
    _subjectTEController.dispose();
    _descriptionTEController.dispose();
    super.dispose();
  }
}
