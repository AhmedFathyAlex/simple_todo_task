
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_todo_task/data/task_model.dart';

class TodoController extends GetxController {
  var tasks = <TaskModel>[].obs;
  late SharedPreferences storage;
  TextEditingController taskController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    initStorage();
  }

  Future<void> initStorage() async {
    storage = await SharedPreferences.getInstance();
    getTasks();
  }

  void getTasks() {
    List<String>? tasksListAsStrings = storage.getStringList('myTasks');
    if (tasksListAsStrings != null) {
      tasks.value = tasksListAsStrings
          .map((task) => TaskModel.fromJson(json.decode(task)))
          .toList();
    }
  }

  void saveTasks() {
    List<String> tasksListAsStrings =
        tasks.map((task) => jsonEncode(task.toJson())).toList();
    storage.setStringList('myTasks', tasksListAsStrings);
  }

  void addTask(String title) {
    tasks.add(TaskModel(title: title, isChecked: false));
    saveTasks();
  }

  void toggleTask(TaskModel task) {
    task.toggle();
    tasks.refresh();
    saveTasks();
  }
}