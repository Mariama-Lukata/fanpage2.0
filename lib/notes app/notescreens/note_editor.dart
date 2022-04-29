import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fanpage2/notes%20app/notesstyle/notesstyle.dart';
import 'package:flutter/material.dart';


class NotesEditorScreen extends StatefulWidget {
  const NotesEditorScreen({Key? key}) : super(key: key);

  @override
  State<NotesEditorScreen> createState() => _NotesEditorScreenState();
}

class _NotesEditorScreenState extends State<NotesEditorScreen> {
  int color_id = Random().nextInt(AppStyle.cardsColor.length);
  String date = DateTime.now().toString();
  TextEditingController _titleEditingController = TextEditingController();
  TextEditingController _mainController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyle.cardsColor[color_id],
      appBar: AppBar(
        backgroundColor: AppStyle.cardsColor[color_id],
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text("Add a new Note"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          TextField(
            controller: _titleEditingController,
            decoration: InputDecoration(
                border: InputBorder.none, hintText: "Note Title"),
            style: AppStyle.mainTitle,
          ),
          SizedBox(
            height: 8.0,
          ),
          Text(
            date,
            style: AppStyle.dateTitle,
          ),
          SizedBox(
            height: 28.0,
          ),
          TextField(
            controller: _mainController,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            decoration: InputDecoration(
                border: InputBorder.none, hintText: "Note content"),
            style: AppStyle.mainContent,
          ),
        ]),
      ),
      
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppStyle.accentColor,
        onPressed: () async {
          FirebaseFirestore.instance.collection("messages").add({
           "color_id": color_id,
           "creation_date": date,
           "note_content": _mainController.text,
           "notes_title": _titleEditingController.text
          }).then((value) {
            print(value.id);
            Navigator.pop(context);
          }).catchError(
              (error) => print("Error failed to add note due to $error"));
        },
        child: Icon(Icons.save) ,
      ),
      
    
    );
  }
}
