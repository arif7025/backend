import 'package:backend/auth/task_model1.dart';
import 'package:backend/auth/task_serivce1.dart';
import 'package:flutter/material.dart';

class taskproviderauth extends ChangeNotifier {
  TaskServiceauth service = TaskServiceauth();
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
