import 'package:flutter/material.dart';

import '../models/note_modal.dart';

class NoteDetails extends StatelessWidget {
  const NoteDetails({Key? key, required this.notes}) : super(key: key);

  final Note notes;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${notes.title}}'),
      ),
      body: Container(
        child: Text(notes.description ?? ''),
      ),
    );
  }
}
