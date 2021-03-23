import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:loja/models/iten_size.dart';

class Product extends ChangeNotifier {
  final Firestore firestore = Firestore.instance;

  DocumentReference get firestoreRef => firestore.document('products/$id');

  Product.fromDocument(DocumentSnapshot doc) {
    id = doc.documentID;
    name = doc['name'] as String;
    description = doc['description'] as String;
    images = List<String>.from(doc['images'] as List<dynamic>);
    sizes = (doc.data['sizes'] as List<dynamic> ?? [])
        .map((sizesMap) => ItemSize.fromMap(sizesMap as Map<String, dynamic>))
        .toList();
  }
  Product({this.id, this.name, this.description, this.images, this.sizes}) {
    images = images ?? [];
    sizes = sizes ?? [];
  }

  String id;
  String name;
  String description;
  List<String> images;
  List<ItemSize> sizes;
  List<dynamic> newImages;

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

  num get basePrice {
    num loewst = double.infinity;

    for (final size in sizes) {
      if (size.price < loewst && size.hasStock) {
        loewst = size.price;
      }
    }
    return loewst;
  }

  ItemSize findSize(String size) {
    return sizes.firstWhere((s) => s.name == size);
  }

  Product clone() {
    return Product(
        id: this.id,
        name: name,
        description: description,
        images: List.from(images),
        sizes: sizes.map((e) => e.clone()).toList());
  }

  Future<void> save() async {
    final Map<String, dynamic> data = {
      'name': name,
      'description': description,
      'sizes': exportSizeList()
    };

    if (id == null) {
      final doc = await firestore.collection('products').add(data);
      id = doc.documentID;
    } else {
      await firestoreRef.updateData(data);
    }
  }

  List<Map<String, dynamic>> exportSizeList() {
    return sizes.map((size) => size.toMap()).toList();
  }
}
