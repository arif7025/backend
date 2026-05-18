

import 'package:backend/streambulder/stream_home.dart';
import 'package:backend/streambulder/stream_login.dart';
import 'package:backend/streambulder/stream_user_provider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

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
  TextEditingController phonecontroller = TextEditingController();
  TextEditingController addresscontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<Auth_Provider>(context);
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

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: phonecontroller,
              decoration: InputDecoration(
                hintText: 'Phone',

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 20),
            SizedBox(height: 20),
            TextFormField(
              controller: addresscontroller,
              decoration: InputDecoration(
                hintText: 'address',

                fillColor: const Color(0xFFF3E9B5),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 20),

            const SizedBox(height: 10),

            TextFormField(
              controller: passwordcontroller,
              obscureText: ishidden,
              decoration: InputDecoration(
                hintText: "*************",

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
                await provider.signup(
                  emailcontroller.text,
                  passwordcontroller.text,
                  namecontroller.text,
                  addresscontroller.text,
                  phonecontroller.text,
                );
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
