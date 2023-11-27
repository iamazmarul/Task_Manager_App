import 'package:flutter/material.dart';
import 'package:task_manager/data/models/task.dart';

class ItemTaskCard extends StatelessWidget {
  const ItemTaskCard({
    super.key,
    required this.task,
  });

  final Task task;
  Color getStatusColor() {
    switch (task.status) {
      case 'New':
        return Colors.blue;
      case 'Progress':
        return Colors.purple;
      case 'Completed':
        return Colors.green;
      case 'Cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              task.title ?? "",
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 18,
              ),
            ),
            const SizedBox(
              height: 4,
            ),
            Text(task.description ?? ""),
            const SizedBox(
              height: 8,
            ),
            Text(
              "Date: ${task.createdDate}",
              style: const TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Chip(
                  label: Text(
                    task.status ?? "New",
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  backgroundColor: getStatusColor(),
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
                ),
                Wrap(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.delete_forever_outlined,
                        color: Colors.red,
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.edit,
                        color: Colors.green,
                      ),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
