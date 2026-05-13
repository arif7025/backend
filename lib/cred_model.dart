import 'package:backend/task_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Cred_modelScreen extends StatefulWidget {
  const Cred_modelScreen({super.key});

  @override
  State<Cred_modelScreen> createState() => _Cred_modelState();
}

class _Cred_modelState extends State<Cred_modelScreen> {
  TextEditingController titlecontroller = TextEditingController();
  TextEditingController desccontroller = TextEditingController();
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<TaskProvider2>(context, listen: false).geting();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TaskProvider2>(context);
    return Scaffold(
      appBar: AppBar(title: Text('My App')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextFormField(
              controller: titlecontroller,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                hintText: "Title",
              ),
            ),
            SizedBox(height: 15),
            TextFormField(
              controller: desccontroller,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                hintText: "Description",
              ),
            ),
            SizedBox(height: 15),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  if (provider.isEdit) {
                    provider.updating(
                      titlecontroller.text,
                      desccontroller.text,
                    );
                  } else {
                    provider.adding(titlecontroller.text, desccontroller.text);
                    titlecontroller.clear();
                    desccontroller.clear();
                  }
                },
                child: Text(provider.isEdit ? "update Task" : "Add Task"),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: provider.storingdata.length,

                itemBuilder: (context, index) {
                  final task = provider.storingdata[index];
                  return Card(
                    child: ListTile(
                      title: Text(task.title),
                      subtitle: Text(task.description),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () {
                              provider.startEdit(task.id!);
                            },
                            icon: Icon(Icons.edit),
                          ),
                          IconButton(
                            onPressed: () {
                              provider.deleting(task.id!);
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
