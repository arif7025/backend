import 'package:backend/streambulder/stram_task_model.dart';
import 'package:backend/streambulder/stream_task_service.dart';
import 'package:flutter/material.dart';

class taskproviderauth extends ChangeNotifier {
  TaskServiceauth service = TaskServiceauth();

  bool isEdit = false;
  String? editingid ;
  void startEdit(String editid) {
    isEdit = true;
    editingid = editid;
    notifyListeners();
  }

  Future<void> adding(String title, String description) async {
    await service.addTask(TaskModel(title: title, description: description));
    geting();
  }


  Stream<List<TaskModel>> geting()  {
    return service.getTask();
  
  }

  Future<void> deleting(String id) async {
    await service.delettask(id);
    geting();
  }

  Future<void> updating(String title, String description) async {
    await service.updateTask(
      TaskModel(title: title, description: description, id: editingid),
    );
    editingid = null;
    isEdit = false;
    geting();
  }
}
