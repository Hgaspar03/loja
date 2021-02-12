import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:loja/models/iten_size.dart';

class Product extends ChangeNotifier {
  Product.fromDocument(DocumentSnapshot doc) {
    id = doc.documentID;
    name = doc['name'] as String;
    description = doc['description'] as String;
    images = List<String>.from(doc['images'] as List<dynamic>);
    sizes = (doc.data['sizes'] as List<dynamic> ?? [])
        .map((sizesMap) => ItemSize.fromMap(sizesMap as Map<String, dynamic>))
        .toList();
  }

  String id;
  String name;
  String description;
  List<String> images;
  List<ItemSize> sizes;

  ItemSize _selectedSize;

  ItemSize get selectedSize => _selectedSize;

  set selectedSize(ItemSize size) {
    _selectedSize = size;
    notifyListeners();
  }

  int get totalStock {
    int stock = 0;

    for (ItemSize size in sizes) {
      stock += size.stock;
    }
    return stock;
  }

  bool get hasStock => totalStock > 0;

  ItemSize findSize(String size) {
    return sizes.firstWhere((s) => s.name == size);
  }
}
