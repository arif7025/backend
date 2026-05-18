import 'dart:developer';

import 'package:backend/streambulder/stram_task_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TaskServiceauth {
  CollectionReference ref = FirebaseFirestore.instance.collection('Task');

  Future<void> addTask(TaskModel task) async {
    final id = ref.doc().id;
    task.id = id;
    final fireauth = FirebaseAuth.instance;
    final userid = fireauth.currentUser!.uid;
    task.userid = userid;
    try {
      await ref.doc(id).set(task.toMap());
    } catch (e) {
      log(e.toString());
    }
  }

  // Future<List<TaskModel>> getTask() async {
  //   final fireauth = FirebaseAuth.instance;
  //   final userid = fireauth.currentUser!.uid;

  //   try {
  //     final snapshot = await ref.where('userid', isEqualTo: userid).get();
  //     return snapshot.docs.map((e) {
  //       return TaskModel.froMap(e.data() as Map<String, dynamic>);
  //     }).toList();
  //   } catch (e) {
  //     log(e.toString());
  //     return [];
  //   }
  // }

 

Stream<List<TaskModel>> getTask() {
  final fireauth = FirebaseAuth.instance;
  final userid = fireauth.currentUser!.uid;

  return ref
      .where('userid', isEqualTo: userid)
      .snapshots()
      .map((snapshot) {
    return snapshot.docs.map((e) {
      return TaskModel.froMap(
        e.data() as Map<String, dynamic>,
      );
    }).toList();
  });
}
  

  Future<void> delettask(String id) async {
    try {
      await ref.doc(id).delete();
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> updateTask(TaskModel task) async {
    try {
      await ref.doc(task.id).update(task.toMap());
    } catch (e) {
      log(e.toString());
    }
  }
}
