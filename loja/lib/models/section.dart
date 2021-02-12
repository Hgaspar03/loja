import 'package:cloud_firestore/cloud_firestore.dart';

class Section {
  Section.fromDocument(DocumentSnapshot doc) {
    name = doc.data['name'] as String;
    type = doc.data['type'] as String;
  }

  String name;
  String type;
}
