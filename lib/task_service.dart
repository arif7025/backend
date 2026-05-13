import 'dart:developer';


import 'package:backend/task_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TaskService {
  CollectionReference ref = FirebaseFirestore.instance.collection('Task');

  Future<void> addTask(TaskModel task) async {
    final id = ref.doc().id;
    task.id = id;
    try {
      await ref.doc(id).set(task.toMap());
    } catch (e) {
      log(e.toString());
    }
  }

  Future<List<TaskModel>> getTask() async {
    try {
      final snapshot = await ref.get();
      return snapshot.docs.map((e) {
        return TaskModel.froMap(e.data() as Map<String, dynamic>);
      }).toList();
    } catch (e) {
      log(e.toString());
      return [];
    }
  }

  Future<void> delettask(String id) async {
    try{
    await ref.doc(id).delete();
    }catch(e){
           log(e.toString());
 
    }
  }

  Future<void> updateTask(TaskModel task) async {
    try{
    await ref.doc(task.id).update(task.toMap());
    }catch(e){
           log(e.toString());
    }
  }
}
