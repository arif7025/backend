


import 'package:backend/firebase_options.dart';
import 'package:backend/streambulder/splash_screen.dart';

import 'package:backend/streambulder/stram_task_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'streambulder/stream_user_provider.dart';


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
      create: (_)=> taskproviderauth(),
      
      ),
      ChangeNotifierProvider(create: (_)=> Auth_Provider())
    ],
      child: MaterialApp(debugShowCheckedModeBanner: false, home: SplashScreen()));
  }
}
