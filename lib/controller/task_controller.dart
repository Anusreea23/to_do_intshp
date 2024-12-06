import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:to_do_intshp/model/task_model.dart';
import 'package:to_do_intshp/utils/app_sessions.dart';

class TaskController with ChangeNotifier {
  List<TaskModel> getData = [];

  // Fetch data from Hive
  getHiveData() {
    var box = Hive.box<TaskModel>(AppSessions.notebox);
    getData = box.values.toList();
    log(getData[0].task.toString());
    log(box.values.length.toString());
    notifyListeners();
  }

  // Delete data from Hive
  deleteHiveData(int index) async {
    var box = Hive.box<TaskModel>(AppSessions.notebox);
    await box.deleteAt(index);

    getHiveData();
    notifyListeners();
  }

  // Update data in Hive
  updateHiveData(int index, TaskModel updatedTask) async {
    var box = Hive.box<TaskModel>(AppSessions.notebox);

    await box.putAt(index, updatedTask);

    getHiveData();
    notifyListeners();
  }
}
