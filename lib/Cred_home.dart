import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CredHomeScreen extends StatefulWidget {
  const CredHomeScreen({super.key});

  @override
  State<CredHomeScreen> createState() => _CredHomeScreenState();
}

class _CredHomeScreenState extends State<CredHomeScreen> {
  List<String> Task = ['task 1 :', 'task 2 :', 'task 3 :', 'task 4 :'];
  List<String> Description = [
    'description :',
    'description :',
    'description :',
    'description :',
  ];
  TextEditingController textcontroller = TextEditingController();
  TextEditingController descriptioncontroller = TextEditingController();
  CollectionReference ref = FirebaseFirestore.instance.collection('Task');
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
              onPressed: () async {
                // ref.add({'task': textcontroller.text,'description':descriptioncontroller.text});
                // ref.doc('task 1').set({'task': textcontroller.text,'description':descriptioncontroller.text});//if  ou want a specific id we can use
                final doc = ref.doc(
                  'task 2',
                ); //if  ou want a specific id we can use
                await doc.set({
                  'task': textcontroller.text,
                  'description': descriptioncontroller.text,
                });
                Fluttertoast.showToast(msg: ' added success fully');
              },
              child: Text("add task"),
            ),
            SizedBox(height: 15),
            ElevatedButton(onPressed: () {}, child: Text('Get')),
            SizedBox(height: 15),
            Expanded(
              child: ListView.builder(
                itemCount: Task.length,

                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text(Task[index]),
                      subtitle: Text(Description[index]),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [Icon(Icons.edit), Icon(Icons.delete)],
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
