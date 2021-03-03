import 'package:cloud_firestore/cloud_firestore.dart';
import 'section_item.dart';

class Section {
  Section.fromDocument(DocumentSnapshot doc) {
    name = doc.data['name'] as String;
    type = doc.data['type'] as String;
    items = (doc.data['items'] as List)
        .map((e) => SectionItem.fromMap(e as Map<String, dynamic>))
        .toList();
  }

  String name;
  String type;
  List<SectionItem> items;

  @override
  String toString() {
    return "section[name: $name, type: $type, items: $items]";
  }
}
