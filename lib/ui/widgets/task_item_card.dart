import 'package:flutter/material.dart';
import 'package:task_manager/data/models/task.dart';
import 'package:task_manager/data/network_caller/network_caller.dart';
import 'package:task_manager/data/utility/urls.dart';

enum TaskStatus {
  New,
  Progress,
  Completed,
  Cancelled,
}

class ItemTaskCard extends StatefulWidget {
  const ItemTaskCard({
    super.key,
    required this.task,
    required this.onStatusChange,
    required this.showProgress,
  });

  final Task task;
  final VoidCallback onStatusChange;
  final Function(bool) showProgress;

  @override
  State<ItemTaskCard> createState() => _ItemTaskCardState();
}

class _ItemTaskCardState extends State<ItemTaskCard> {
  Future<void> updateTaskStatus(String status) async {
    widget.showProgress(true);
    final response = await NetworkCaller()
        .getRequest(Urls.getUpdateTaskStatus(widget.task.sId ?? "", status));
    if (response.isSuccess) {
      widget.onStatusChange();
    }
    widget.showProgress(false);
  }

  Future<void> deleteTask() async {
    widget.showProgress(true);
    final response = await NetworkCaller().getRequest(
      Urls.getDeleteTask(widget.task.sId ?? ""),
    );
    if (response.isSuccess) {
      widget.onStatusChange();
    }
    widget.showProgress(false);
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
              widget.task.title ?? "",
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 18,
              ),
            ),
            const SizedBox(
              height: 4,
            ),
            Text(widget.task.description ?? ""),
            const SizedBox(
              height: 8,
            ),
            Text(
              "Date: ${widget.task.createdDate}",
              style: const TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Chip(
                  label: Text(
                    widget.task.status ?? "New",
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  backgroundColor: getStatusColor(),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 4.0),
                ),
                Wrap(
                  children: [
                    IconButton(
                      onPressed: () {
                        showDeleteConfirmationDialog();
                      },
                      icon: const Icon(
                        Icons.delete_forever_outlined,
                        color: Colors.red,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        showUpdateStatusModel();
                      },
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

  void showUpdateStatusModel() {
    List<ListTile> items = TaskStatus.values
        .map((e) => ListTile(
              title: Text(e.name),
              onTap: () {
                updateTaskStatus(e.name);
                Navigator.pop(context);
              },
            ))
        .toList();

    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Update Status"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: items,
            ),
            actions: [
              ButtonBar(
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Cancel",
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      )),
                ],
              )
            ],
          );
        });
  }

  void showDeleteConfirmationDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Delete Task"),
          content: const Text("Are you sure you want to delete this task?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                deleteTask();
                Navigator.pop(context); // Close the dialog
              },
              child: const Text(
                "Delete",
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Color getStatusColor() {
    switch (widget.task.status) {
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
}