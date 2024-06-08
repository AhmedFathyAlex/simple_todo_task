import 'package:flutter/material.dart';
import 'package:simple_todo_task/data/task_model.dart';

class TaskView extends StatelessWidget {
  const TaskView({super.key, required this.task, required this.onToggle});
  final TaskModel task;
  final ValueChanged<TaskModel> onToggle;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        task.title,
        style: task.isChecked ? const TextStyle(decoration: TextDecoration.lineThrough) : null,
      ),
      trailing: Checkbox(
        onChanged: (value) {
          onToggle(task);
        },
        value: task.isChecked,
      ),
    );
  }
}
