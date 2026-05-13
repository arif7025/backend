import 'package:backend/task_model.dart';
import 'package:backend/task_service.dart';
import 'package:flutter/material.dart';

class TaskProvider2 extends ChangeNotifier {
  TaskService service = TaskService();
  List<TaskModel> storingdata = [];
  bool isEdit = false;
  String? editingid ;
  void startEdit(String editid) {
    isEdit = true;
    editingid = editid;
    notifyListeners();
  }

  Future<void> adding(String title, String description) async {
    await service.addTask(TaskModel(title: title, description: description));
   await geting();
  }

  Future<void> geting() async {
    storingdata = await service.getTask();
    notifyListeners();
  }

  Future<void> deleting(String id) async {
    await service.delettask(id);
   await geting();
  }

  Future<void> updating(String title, String description) async {
    await service.updateTask(
      TaskModel(title: title, description: description, id: editingid),
    );
    editingid = null;
    isEdit = false;
  await  geting();
  }
}
