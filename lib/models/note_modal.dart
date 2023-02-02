import 'package:cloud_firestore/cloud_firestore.dart';

class Note {
  late String id;
  late String title;
  String? description;
  late String color;
  late DateTime date;

  Note.fromjson(Map<String, dynamic> json) {
    id = json["id"];
    title = json['title'];
    description = json['description'];
    color = json['color'];
    Timestamp temDate = json['date'];
    date = DateTime.fromMillisecondsSinceEpoch(temDate.seconds * 1000);
  }
}
