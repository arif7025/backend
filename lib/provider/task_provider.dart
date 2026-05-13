
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';

class TaskProvider extends ChangeNotifier {
  CollectionReference ref = FirebaseFirestore.instance.collection('Task');

  List<Map<String, dynamic>> alltask = [];

  bool isEdit = false;
  String editId = "";
  TextEditingController titlecontroller = TextEditingController();
  TextEditingController desccontroller = TextEditingController();

  Future<void> loadTask() async {
    final tasks = await ref.get();
    
    alltask = tasks.docs.map((e) {
      return {'title': e['task'], 'description': e['description'], 'id': e.id};
    }).toList();
    notifyListeners();
  }

  Future<void> addTask() async {
    String id = DateTime.now().millisecondsSinceEpoch.toString();

    await ref.doc(id).set({
      'task': titlecontroller.text,
      'description': desccontroller.text,
    });
    titlecontroller.clear();
    desccontroller.clear();
    loadTask();
  }

  Future<void> deleteTask(String id) async {
    await ref.doc(id).delete();
    loadTask();
  }

  Future<void> updateTask() async {
    await ref.doc(editId).update({
      "task": titlecontroller.text,
      "description": desccontroller,
    });

    isEdit = false;
    editId = "";
    titlecontroller.clear();
    desccontroller.clear();
    loadTask();
  }

  void setEdit(Map<String, dynamic> task) {
    isEdit = true;
    editId = task['id'];

    titlecontroller.text = task['title'];
    desccontroller.text = task['description'];

    notifyListeners();
  }
}
