import 'package:flutter/foundation.dart';

class TaskModel {
  String? id;
  String title;
  String description;
  String? userid;

  TaskModel({
    this.id,
    required this.title,
    required this.description,
     this.userid,
  });

  Map<String, String?> toMap() {
    return {
      'title': title,
      'description': description,
      "id": id,
      "userid": userid,
    };
  }

  factory TaskModel.froMap(Map<String, dynamic> map) {
    return TaskModel(
      id: map["id"] ?? "",
      title: map["title"] ?? "",
      description: map["description"] ?? "",
      userid: map["userid"],
    );
  }
}
