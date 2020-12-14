import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  Product.fromDocument(DocumentSnapshot doc) {
    id = doc.documentID;
    name = doc['name'] as String;
    description = doc['description'] as String;
    images = List<String>.from(doc['images'] as List<dynamic>);
  }

  String id;
  String name;
  String description;
  List<String> images;
}
