import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swipe_action_cell/flutter_swipe_action_cell.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xasus_qore/models/note_modal.dart';

import '../screens/note_details.dart';

class CardDesign extends StatefulWidget {
  CardDesign({required this.note});

  final Note note;

  @override
  State<CardDesign> createState() => _CardDesignState();
}

FirebaseFirestore firestore = FirebaseFirestore.instance;

deletNote(String id) async {
  final delete = firestore.collection("notes");
  delete.doc(id).delete();

  return delete;
}

class _CardDesignState extends State<CardDesign> {
  @override
  Widget build(BuildContext context) {
    return SwipeActionCell(
      key: ObjectKey(widget.note.id),
      trailingActions: <SwipeAction>[
        SwipeAction(
            title: "delete",
            onTap: (CompletionHandler handler) async {
              await deletNote(widget.note.id);
              await handler(true);
              setState(() {});
            },
            color: Colors.red),
      ],
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Material(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          child: InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => NoteDetails(notes: widget.note),
              ),
            ),
            child: Container(
              width: double.infinity,
              height: 180,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "${widget.note.title}",
                            style: GoogleFonts.poppins(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.timer_outlined,
                                size: 18,
                                color: Colors.grey,
                              ),
                              const SizedBox(width: 5),
                              Text(
                                "${widget.note.date.second} Minutes",
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Text(
                            ' ${widget.note.description ?? ''}',
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                            ),
                            maxLines: 4,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: 36,
                    height: double.infinity,
                    decoration: BoxDecoration(
                        color: Color(int.parse('0xff' + widget.note.color)),
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        )),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
