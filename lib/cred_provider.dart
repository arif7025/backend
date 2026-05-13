import 'package:backend/provider/task_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CredProviderScreen extends StatefulWidget {
  const CredProviderScreen({super.key});

  @override
  State<CredProviderScreen> createState() => _CredProviderScreenState();
}

class _CredProviderScreenState extends State<CredProviderScreen> {
  @override
  void initState() {
   

    super.initState();
     Future.microtask(() {
    Provider.of<TaskProvider>(context, listen: false).loadTask();
     });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TaskProvider>(context);
    return Scaffold(
      appBar: AppBar(title: Text('My App')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextFormField(
              controller: provider.titlecontroller,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                hintText: "Task",
              ),
            ),
            SizedBox(height: 15),
            TextFormField(
              controller: provider.desccontroller,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                hintText: "Description",
              ),
            ),
            SizedBox(height: 15),
            ElevatedButton(
              onPressed: () {
                if (provider.isEdit) {
                  provider.updateTask();
                } else {
                  provider.addTask();
                }
              },
              child: Text(provider.isEdit ? "update Task" : "Add Task"),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: provider.alltask.length,

                itemBuilder: (context, index) {
                  final task = provider.alltask[index];
                 return Card(
                    child: ListTile(
                      title: Text(task['title']),
                      subtitle: Text(task['description']),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () {
                              provider.setEdit(task);
                            },
                            icon: Icon(Icons.edit),
                          ),
                          IconButton(
                            onPressed: () {
                              provider.deleteTask(task['id']);
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
