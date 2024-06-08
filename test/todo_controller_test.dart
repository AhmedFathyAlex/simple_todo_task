import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:simple_todo_task/controller/todo_controller.dart';
import 'package:simple_todo_task/data/task_model.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late TodoController todoController;
  late SharedPreferences sharedPreferences;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    sharedPreferences = await SharedPreferences.getInstance();
    todoController = Get.put(TodoController());
    await todoController.initStorage();
  });

  tearDown(() {
    Get.reset();
  });

  test('Initial task list is empty', () {
    expect(todoController.tasks.length, 0);
  });

  test('Add a task', () {
    todoController.addTask('Test Task');
    expect(todoController.tasks.length, 1);
    expect(todoController.tasks[0].title, 'Test Task');
    expect(todoController.tasks[0].isChecked, false);
  });

  test('Toggle a task', () {
    todoController.addTask('Test Task');
    final task = todoController.tasks[0];
    todoController.toggleTask(task);
    expect(todoController.tasks[0].isChecked, true);
    todoController.toggleTask(task);
    expect(todoController.tasks[0].isChecked, false);
  });

  test('Save tasks to SharedPreferences', () async {
    todoController.addTask('Test Task');
    todoController.saveTasks();
    final tasksListAsStrings = sharedPreferences.getStringList('myTasks');
    expect(tasksListAsStrings, isNotNull);
    final taskJson = json.decode(tasksListAsStrings![0]);
    expect(taskJson['title'], 'Test Task');
    expect(taskJson['isChecked'], false);
  });

  test('Load tasks from SharedPreferences', () async {
    final tasksListAsStrings = [
      jsonEncode(TaskModel(title: 'Loaded Task', isChecked: false).toJson())
    ];
    await sharedPreferences.setStringList('myTasks', tasksListAsStrings);

    await todoController.initStorage();
    expect(todoController.tasks.length, 1);
    expect(todoController.tasks[0].title, 'Loaded Task');
    expect(todoController.tasks[0].isChecked, false);
  });
}
