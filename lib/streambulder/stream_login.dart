


import 'package:backend/streambulder/stream_home.dart';
import 'package:backend/streambulder/stream_signup.dart';
import 'package:backend/streambulder/stream_user_provider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  bool ishidden = true;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<Auth_Provider>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
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
                await provider.signin(
                  emailcontroller.text,
                  passwordcontroller.text,
                );
                Fluttertoast.showToast(msg: "login Successfull");
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Cred_modelScreen()),
                );
              },
              child: Text("Log In"),
            ),

            const SizedBox(height: 31),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Don’t have an account? '),

                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => SiginupScreen()),
                    );
                  },
                  child: const Text(
                    'Sign Up',
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
