import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/note_modal.dart';

class AddNote extends StatefulWidget {
  const AddNote({
    Key? key,
  }) : super(key: key);

  @override
  _AddNoteState createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  final _contorollerT = TextEditingController();
  final _contorollerD = TextEditingController();
  final _contorollerC = TextEditingController();

  void insertNote(String title, String description, String color) async {
    FirebaseFirestore insert = FirebaseFirestore.instance;

    final getNote = insert.collection("notes");

    await getNote
        .add({'title': title, 'description': description, 'color': color});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          TextField(
            controller: _contorollerT,
            decoration: InputDecoration(),
          ),
          TextField(
            controller: _contorollerD,
            decoration: InputDecoration(),
          ),
          TextField(
            controller: _contorollerC,
            decoration: InputDecoration(),
          ),
          MaterialButton(
            onPressed: () {
              setState(() {
                insertNote(
                  _contorollerT.text.trim(),
                  _contorollerD.text.trim(),
                  _contorollerC.text.trim(), //
                );
              });
            },
            child: Text("AddNoteState"),
          )
        ],
      ),
    );
  }
}
