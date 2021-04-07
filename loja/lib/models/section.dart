import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'section_item.dart';

class Section extends ChangeNotifier {
  Section.fromDocument(DocumentSnapshot doc) {
    name = doc.data['name'] as String;
    type = doc.data['type'] as String;
    items = (doc.data['items'] as List)
        .map((e) => SectionItem.fromMap(e as Map<String, dynamic>))
        .toList();
  }

  Section({this.name, this.type, this.items}) {
    items = items ?? [];
  }

  String name;
  String type;
  List<SectionItem> items;

  @override
  String toString() {
    return "section[name: $name, type: $type, items: $items]";
  }

  Section clone() {
    return Section(
        name: name, type: type, items: items.map((e) => e.clone()).toList());
  }

  void addItem(SectionItem sectionItem) {
    items.add(sectionItem);
    notifyListeners();
  }

  void removeItem(SectionItem item) {
    items.remove(item);
    notifyListeners();
  }
}
