import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:loja/models/section.dart';

class HomeManager extends ChangeNotifier {
  HomeManager() {
    _loadSections();
  }

  final List<Section> _sections = [];
  List<Section> _editingSections = [];
  bool editing = false;
  bool loading = false;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> _loadSections() async {
    _firestore.collection('home').orderBy('pos').snapshots().listen((snapshot) {
      _sections.clear();
      for (final DocumentSnapshot document in snapshot.docs) {
        _sections.add(Section.fromDocument(document));
      }
      notifyListeners();
    });
  }

  void enterEditing() {
    editing = true;

    _editingSections = _sections.map((s) => s.clone()).toList();
    notifyListeners();
  }

  Future<void> saveEditing() async {
    bool valid = true;
    for (final section in _editingSections) {
      if (!section.valid()) valid = false;
    }

    if (!valid) return;

    loading = true;
    notifyListeners();

    int pos = 0;
    for (final section in _editingSections) {
      await section.save(pos);
      pos++;
    }

    for (final section in List.from(sections)) {
      if (_editingSections.any((element) => element.id == section.id)) {
        await section.delete();
      }
    }

    loading = false;
    editing = false;
    notifyListeners();
  }

  void descartEditing() {
    editing = false;
    notifyListeners();
  }

  List<Section> get sections {
    if (editing) return _editingSections;
    return _sections;
  }

  void addSection(Section section) {
    _editingSections.add(section);
    notifyListeners();
  }

  void removeSection(Section section) {
    _editingSections.remove(section);
    notifyListeners();
  }
}
