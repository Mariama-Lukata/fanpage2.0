import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fanpage2/google_sign_in.dart';
import 'package:fanpage2/login.dart';
import 'package:fanpage2/notes%20app/notescreens/note_editor.dart';
import 'package:fanpage2/notes%20app/notescreens/note_reader.dart';
import 'package:fanpage2/notes%20app/notewidgets/note_card.dart';
import 'package:fanpage2/reused.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  
  bool widgetVisible = false;

  void hideWidget() {
    setState(() {
      widgetVisible = false;
    });
  }

  Future checkUser(context) async {
    User? user = FirebaseAuth.instance.currentUser;
    final DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection("user")
        .doc(user?.uid)
        .get();
    String role = snap['role'];
    if (role == "user") {
      hideWidget();
    } else {
      widgetVisible = false;
    }
  }



  @override
  Widget build(BuildContext context) {
      checkUser(context);
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text("FanPage"),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: ()  {
                   createAlertDialog(
                      context, "Are You sure you want to logout?");
                  final provider =
                      Provider.of<GoogleSignInProvider>(context, listen: false);

                  provider.logout();
                 
                  
                },
                icon: Icon(Icons.logout))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Your Recent messages"),
              const SizedBox(
                height: 20.0,
              ),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("messages")
                      .snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    if (snapshot.hasData) {
                      return GridView(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2),
                        children: snapshot.data!.docs
                            .map((note) => noteCard(() {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            NoteReaderScreen(note),
                                      ));
                                }, note))
                            .toList(),
                      );
                    }
                    return Text(
                      "there's no Notes",
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: (widgetVisible)
            ? FloatingActionButton.extended(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NotesEditorScreen()));
                },
                label: Text("Add Note"),
                icon: Icon(Icons.add))
            : FloatingActionButton.extended(
                onPressed: () {},
                label: Text(""),
              ));
  }
}
