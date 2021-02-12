import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loja/models/section.dart';

class HomeManager {
  HomeManager() {
    _loadSeactions();
  }

  List<Section> sections = [];

  final Firestore _firestore = Firestore.instance;

  Future<void> _loadSeactions() async {
    sections.clear();
    _firestore.collection('home').snapshots().listen((snapshot) {
      for (final DocumentSnapshot document in snapshot.documents) {
        sections.add(Section.fromDocument(document));
      }
    });
  }
}
