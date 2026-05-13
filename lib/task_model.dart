
class TaskModel {
  String? id;
  String title;
  String description;

  TaskModel({this.id, required this.title, required this.description});

  Map<String, String?> toMap() {
    return {'title': title, 'description': description,"id":id};
  }
 
   factory  TaskModel.froMap( Map<String,dynamic> map   ) {
    return TaskModel(id: map["id"]??"", title:map["title"]??"", description:map["description"]??"");
  }
}
