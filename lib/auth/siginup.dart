import 'dart:developer';

import 'package:backend/auth/home.dart';
import 'package:backend/auth/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SiginupScreen extends StatefulWidget {
  const SiginupScreen({super.key});

  @override
  State<SiginupScreen> createState() => _SiginupScreenState();
}

class _SiginupScreenState extends State<SiginupScreen> {
  bool ishidden = true;
  TextEditingController namecontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign Up')),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            SizedBox(height: 20),
            TextFormField(
              controller: namecontroller,
              decoration: InputDecoration(
                hintText: 'Name',
                filled: true,
                fillColor: const Color(0xFFF3E9B5),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 20),

            TextFormField(
              controller: emailcontroller,
              decoration: InputDecoration(
                hintText: 'example@example.com',
                filled: true,
                fillColor: const Color(0xFFF3E9B5),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 10),

            TextFormField(
              controller: passwordcontroller,
              obscureText: ishidden,
              decoration: InputDecoration(
                hintText: "*************",
                filled: true,
                fillColor: const Color(0xFFF3E9B5),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      ishidden = !ishidden;
                    });
                  },
                  icon: Icon(
                    ishidden ? Icons.visibility_off : Icons.visibility,
                    color: const Color(0xFFE95322),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                try {
                  UserCredential userCredential = await FirebaseAuth.instance
                      .createUserWithEmailAndPassword(
                        email: emailcontroller.text,
                        password: passwordcontroller.text,
                      );

                  FirebaseFirestore.instance.collection("users").add({
                    "id": userCredential.user!.uid,
                    "email":emailcontroller.text,
                    "name":namecontroller.text,
                  });
                } catch (e) {
                  log(e.toString());
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(e.toString())));
                }
                Fluttertoast.showToast(msg: 'account created');
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Cred_modelScreen()),
                );
              },
              child: Text("Sign Up"),
            ),

            const SizedBox(height: 31),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Already have an account? '),

                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Login()),
                    );
                  },
                  child: const Text(
                    'Log In',
                    style: TextStyle(color: Color(0xFFE95322)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
