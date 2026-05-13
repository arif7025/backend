import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Cred1Home extends StatefulWidget {
  const Cred1Home({super.key});

  @override
  State<Cred1Home> createState() => _Cred1HomeState();
}

class _Cred1HomeState extends State<Cred1Home> {
  TextEditingController textcontroller = TextEditingController();
  TextEditingController descriptioncontroller = TextEditingController();
  CollectionReference ref = FirebaseFirestore.instance.collection('Task');
  List<Map<String, dynamic>> alltask = [];
  bool isedit = false;
  String editingid = '';
  Future<List<Map<String, dynamic>>> GetTask() async {
    final tasks = await ref.get();
    return tasks.docs.map((e) {
      return {'title': e['task'], 'description': e['description'], 'id': e.id};
    }).toList();
  }

  Future<void> AddTask() async {
    String unicid = DateTime.now().millisecondsSinceEpoch.toString();
    final doc = ref.doc(unicid); //if  ou want a specific id we can use
    await doc.set({
      'task': textcontroller.text,
      'description': descriptioncontroller.text,
    });
    textcontroller.clear();
    descriptioncontroller.clear();
    loadTasks();
  }

  Future<void> UpdateTask(String id) async {
    await ref.doc(id).update({
      'task': textcontroller.text,
      'description': descriptioncontroller.text,
    });
    loadTasks();
    textcontroller.clear();
    descriptioncontroller.clear();
  }

  Future<void> loadTasks() async {
    alltask = await GetTask(); // wait for data
    setState(() {}); // update UI
  }

  @override
  void initState() {
    loadTasks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text('My App'))),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextFormField(
              controller: textcontroller,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                hintText: "task",
              ),
            ),
            SizedBox(height: 15),
            TextFormField(
              controller: descriptioncontroller,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                hintText: "description......",
              ),
            ),
            SizedBox(height: 15),
            ElevatedButton(
              onPressed: () {
                // ref.add({'task': textcontroller.text,'description':descriptioncontroller.text});
                // ref.doc('task 1').set({'task': textcontroller.text,'description':descriptioncontroller.text});//if  ou want a specific id we can use
                if (isedit == true) {
                  UpdateTask(editingid);
                  Fluttertoast.showToast(msg: ' Update success fully');
                } else {
                  AddTask();
                  Fluttertoast.showToast(msg: ' added success fully');
                }
                isedit = false;
              },
              child: Text(isedit ? "Update Task" : "Add Task"),
            ),

            SizedBox(height: 15),
            Expanded(
              child: ListView.builder(
                itemCount: alltask.length,

                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text(alltask[index]['title']),
                      subtitle: Text(alltask[index]['description']),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            onPressed: () {
                              setState(() {
                                isedit = true;
                                editingid = alltask[index]['id'];
                              });
                              textcontroller.text = alltask[index]["title"];
                              descriptioncontroller.text =
                                  alltask[index]['description'];
                            },

                            icon: Icon(Icons.edit),
                          ),
                          IconButton(
                            onPressed: () async {
                              await ref.doc(alltask[index]['id']).delete();
                              alltask.removeAt(index);
                              setState(() {});
                            },
                            icon: Icon(Icons.delete),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
