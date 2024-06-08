import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_todo_task/controller/todo_controller.dart';
import 'package:simple_todo_task/presentation/task_view.dart';

class TodoScreen extends StatelessWidget {
  final TodoController todoController = Get.put(TodoController());

  TodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo App'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return Container(
                color: Colors.teal,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 50.0, horizontal: 25),
                      child: TextField(
                        decoration: const InputDecoration(
                            hintText: "Task title..",
                            border: OutlineInputBorder()),
                        controller: todoController.taskController,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        todoController.addTask(todoController.taskController.text);
                        todoController.taskController.clear();
                        Navigator.pop(context);
                      },
                      child: const Text('Create'),
                    ),
                    const SizedBox(height: 30)
                  ],
                ),
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Obx(() {
            return ListView.builder(
              itemBuilder: (context, index) {
                var task = todoController.tasks[index];
                return TaskView(
                  key: ValueKey(task.title),
                  task: task,
                  onToggle: (task) {
                    todoController.toggleTask(task);
                  },
                );
              },
              itemCount: todoController.tasks.length,
            );
          }),
        ),
      ),
    );
  }
}