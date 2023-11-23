import 'package:flutter/material.dart';
import 'package:task_manager/data/network_caller/network_caller.dart';
import 'package:task_manager/data/network_caller/network_response.dart';
import 'package:task_manager/data/utility/urls.dart';
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
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  bool _createTaskinprogress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    key: _formkey,
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
                            decoration:
                                const InputDecoration(hintText: "Description"),
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
                          child: Visibility(
                            visible: _createTaskinprogress == false,
                            replacement: const Center(
                              child: CircularProgressIndicator(),
                            ),
                            child: ElevatedButton(
                              onPressed: () {
                                createNewTask();
                              },
                              child:
                                  const Icon(Icons.arrow_circle_right_outlined),
                            ),
                          ),
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
    );
  }

  Future<void> createNewTask() async {
    if (_formkey.currentState!.validate()) {
      _createTaskinprogress = true;
      if (mounted) {
        setState(() {});
      }
      final NetworkResponse response =
          await NetworkCaller().postRequest(Urls.createNewTask, body: {
        "title": _subjectTEController.text.trim(),
        "description": _descriptionTEController.text.trim(),
        "status": "New"
      });
      _createTaskinprogress = false;
      if (mounted) {
        setState(() {});
      }
      if(response.isSuccess){
        _subjectTEController.clear();
        _descriptionTEController.clear();
        if(mounted){
          showSnackMessage(context, "Create new task successfully",);
        }
      } else{
        if(mounted){
          showSnackMessage(context, "Create new task failed! Try again", true);
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
