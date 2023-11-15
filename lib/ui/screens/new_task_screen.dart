import 'package:flutter/material.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
floatingActionButton: FloatingActionButton(
  onPressed: (){
    Navigator.push(context, MaterialPageRoute(builder: (context) => const AddNewTaskScreen()));
  }, child: const Icon(Icons.add),
),
      body: SafeArea(
        child: Column(
          children: [
            const ProfileSummaryCard(),
            const SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    CardSummary(
                      count: '9',
                      title: 'New',
                    ),
                    CardSummary(
                      count: '10',
                      title: 'In Progress',
                    ),
                    CardSummary(
                      count: '15',
                      title: 'Completed',
                    ),
                    CardSummary(
                      count: '3',
                      title: 'Cancle',
                    ),
                  ],
                ),
              ),
            ),
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
