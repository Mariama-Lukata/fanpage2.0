import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fanpage2/home.dart';
import 'package:fanpage2/notes%20app/notescreens/note_editor.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class checkRole extends StatefulWidget {
  const checkRole({Key? key}) : super(key: key);

  @override
  State<checkRole> createState() => _checkRoleState();
}

class _checkRoleState extends State<checkRole> {
  String role = 'user';

  void initState() {
    super.initState();
    _roleChecker();
  }

  void _roleChecker() async {
    User? user = FirebaseAuth.instance.currentUser;
    final DocumentSnapshot snap =
        await FirebaseFirestore.instance.collection("user").doc(user?.uid).get();

    setState(() {
      role = snap['role'];
    });

    if (role == "user") {
      navigateNext(home());
    } else if (role == 'admin') {
      navigateNext(home());
    }
  }

  void navigateNext(Widget route) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => route));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        children: [Text("Welcome")],
      )),
    );
  }
}
