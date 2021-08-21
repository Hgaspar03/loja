import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';
import 'section_item.dart';

class Section extends ChangeNotifier {
  Section.fromDocument(DocumentSnapshot doc) {
    id = doc.id;
    name = doc.data()['name'] as String;
    type = doc.data()['type'] as String;
    items = (doc.data()['items'] as List)
        .map((e) => SectionItem.fromMap(e as Map<String, dynamic>))
        .toList();
  }

  Section({this.id, this.name, this.type, this.items}) {
    items = items ?? [];
    originalItems = List.from(items);
  }

  String id;
  String name;
  String type;
  List<SectionItem> items;
  List<SectionItem> originalItems;
  String _error;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;
  DocumentReference get firestoreRef => firestore.doc('home/$id');
  StorageReference get storageRef => storage.ref().child('home/$id');

  String get error => _error;
  set error(String value) {
    _error = value;
    notifyListeners();
  }

  @override
  String toString() {
    return "section[name: $name, type: $type, items: $items]";
  }

  Section clone() {
    return Section(
        id: id,
        name: name,
        type: type,
        items: items.map((e) => e.clone()).toList());
  }

  void addItem(SectionItem sectionItem) {
    items.add(sectionItem);
    notifyListeners();
  }

  void removeItem(SectionItem item) {
    items.remove(item);
    notifyListeners();
  }

  bool valid() {
    if (name == null || name.isEmpty) {
      _error = 'Titulo Invalido';
    } else if (items.isEmpty) {
      _error = 'Insira pelo menos uma imagem';
    } else {
      _error = null;
    }

    return _error == null;
  }

  Future<void> save(int pos) async {
    Map<String, dynamic> data = {'name': name, 'type': type, 'pos': pos};

    if (id == null) {
      final doc = await firestore.collection('home').add(data);
      id = doc.id;
    } else {
      await firestoreRef.update(data);
    }

    for (final item in items) {
      if (item.image is File) {
        final StorageUploadTask task =
            storageRef.child(Uuid().v1()).putFile(item.image as File);
        final StorageTaskSnapshot taskSnapshot = await task.onComplete;
        final String url = await taskSnapshot.ref.getDownloadURL();
        item.image = url;
      }
    }

    for (final original in originalItems) {
      if (!items.contains(original)) {
        try {
          final ref =
              await storage.getReferenceFromUrl(original.image as String);
          ref.delete();
        } catch (e) {
          //continue;
        }
      }
    }

    final Map<String, dynamic> itemdata = {
      'items': items.map((e) => e.toMap()).toList(),
    };
    await firestoreRef.update(itemdata);
  }

  Future<void> delete() async {
    await firestoreRef.delete();
    for (final item in items) {
      try {
        final ref = await storage.getReferenceFromUrl(item.image as String);
        await ref.delete();
      } catch (e) {
        //
      }
    }
  }
}
