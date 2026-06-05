import 'package:backend/streambulder/stram_task_provider.dart';
import 'package:backend/streambulder/stream_login.dart';
import 'package:backend/streambulder/stream_user_provider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class Cred_modelScreen extends StatefulWidget {
  const Cred_modelScreen({super.key});

  @override
  State<Cred_modelScreen> createState() => _Cred_modelState();
}

class _Cred_modelState extends State<Cred_modelScreen> {
  TextEditingController titlecontroller = TextEditingController();
  TextEditingController desccontroller = TextEditingController();
  TextEditingController serchcontroller = TextEditingController();
  late Future<void> taskfuture;
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<taskproviderauth>(context, listen: false).geting();
    });
  }

  @override
  Widget build(BuildContext context) {
    final authprovider = Provider.of<Auth_Provider>(context);
    final provider = Provider.of<taskproviderauth>(context);

    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('My App')),
        leading: IconButton(
          onPressed: () async {
            await authprovider.logout();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => Login()),
            );
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextFormField(
              onChanged: (value) {
                provider.searchTask(value);
              },
              controller: serchcontroller,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                hintText: "Search Task",
              ),
            ),
            SizedBox(height: 20),

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
            ElevatedButton(
              onPressed: () async {
                await authprovider.logout();

                Fluttertoast.showToast(msg: "Logout Successful");

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const Login()),
                );
              },

              child: const Text("log out"),
            ),
            Expanded(
              child: StreamBuilder(
                stream: provider.geting(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }
                  if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }
                  if (snapshot.data!.isEmpty) {
                    return Text("no task Added");
                  }
                  final tasks = snapshot.data!.where((element) {
                    return element.title.toLowerCase().contains(
                          provider.searchText,
                        ) ||
                        element.description.toLowerCase().contains(
                          provider.searchText,
                        );
                  }).toList();
                  return ListView.builder(
                    itemCount: tasks.length,

                    itemBuilder: (context, index) {
                      final task = tasks[index];
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
