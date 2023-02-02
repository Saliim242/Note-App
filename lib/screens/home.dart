import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:xasus_qore/models/note_modal.dart';

import '../components/card.dart';
import 'add_note.dart';

class XasuusQore extends StatefulWidget {
  const XasuusQore({Key? key}) : super(key: key);

  @override
  State<XasuusQore> createState() => _XasuusQoreState();
}

class _XasuusQoreState extends State<XasuusQore> {
  FirebaseFirestore firebase = FirebaseFirestore.instance;

  Future<List<Note>> getNotes() async {
    final noteRef = firebase.collection("notes");
    final data = await noteRef.get();

    // List<Note> notes = [];

    // for (int i = 0; i < data.docs.length; i++) {
    //   Note note = Note.fromjson(data.docs[i].data());
    //   notes.add(note);
    // }
    // return notes;

    return data.docs.map((e) => Note.fromjson(e.data())).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          "My Notes",
          style: TextStyle(
            color: Colors.black54,
            fontSize: 26,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.filter_alt_outlined,
              color: Colors.black54,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              width: double.infinity,
              height: 56,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  hintText: "Search Note Here....",
                  hintStyle: TextStyle(
                    fontSize: 18,
                  ),
                  suffixIcon: Icon(Icons.search, color: Colors.black54),
                ),
              ),
            ),
            Expanded(
              child: FutureBuilder<List<Note>>(
                future: getNotes(),
                builder: (_, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting)
                    return Center(child: CircularProgressIndicator());

                  final notes = snapshot.data!;

                  return ListView.builder(
                      itemCount: notes.length,
                      itemBuilder: (_, int index) {
                        return CardDesign(
                          note: notes[index],
                        );
                      });
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
            context, MaterialPageRoute(builder: (_) => AddNote())),
        child: Icon(
          Icons.add,
        ),
      ),
    );
  }
}
