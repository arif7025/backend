import 'dart:developer';


import 'package:backend/streambulder/stram_user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthSeriveClass {
  final auth = FirebaseAuth.instance;

  Future<void> signup(
    String email,
    String password,
    String name,
    String address,
    String phone,
  ) async {
    try {
      final credential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final uid = credential.user!.uid;
      final usermodel = UserModel(
        id: uid,
        name: name,
        phone: phone,
        address: address,
        email: email,
      );
      FirebaseFirestore.instance.collection("user").add(usermodel.toMap());
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> signin(String email, String password) async {
    await auth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<void> logout() async {
    await auth.signOut();
  }
}
