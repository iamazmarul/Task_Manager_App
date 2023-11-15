import 'package:flutter/material.dart';
import 'package:task_manager/ui/widgets/profile_summary_card.dart';
import 'package:task_manager/ui/widgets/task_item_card.dart';

class TaskCanceledScreen extends StatefulWidget {
  const TaskCanceledScreen({super.key});

  @override
  State<TaskCanceledScreen> createState() => _TaskCanceledScreenState();
}

class _TaskCanceledScreenState extends State<TaskCanceledScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SafeArea(
        child: Column(
          children: [
            const ProfileSummaryCard(),
            Expanded(
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    child: ItemTaskCard(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
