import 'package:backend/auth/login.dart';
import 'package:backend/auth/task_provider1.dart';
import 'package:backend/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(Myapp());
}

class Myapp extends StatelessWidget {
  const Myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
       ChangeNotifierProvider(
      create: (_)=> taskproviderauth()),
    ],
      child: MaterialApp(debugShowCheckedModeBanner: false, home: Login()));
  }
}
