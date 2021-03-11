import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loja/models/section.dart';

class HomeManager {
  HomeManager() {
    _loadSections();
  }

  List<Section> sections = [];

  final Firestore _firestore = Firestore.instance;

  Future<void> _loadSections() async {
    _firestore.collection('home').snapshots().listen((snapshot) {
      sections.clear();
      for (final DocumentSnapshot document in snapshot.documents) {
        sections.add(Section.fromDocument(document));
      }
    });
  }
}
