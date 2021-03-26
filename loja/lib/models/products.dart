import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:loja/models/iten_size.dart';
import 'package:uuid/uuid.dart';

class Product extends ChangeNotifier {
  final Firestore firestore = Firestore.instance;
  FirebaseStorage storage = FirebaseStorage.instance;

  DocumentReference get firestoreRef => firestore.document('products/$id');
  StorageReference get storageRf => storage.ref().child('products').child(id);

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
  List<dynamic> newImages = [];

  final List<String> updateImages = [];

  bool _loading = false;
  bool get loading => _loading;
  set loading(bool isLoading) {
    _loading = isLoading;
    notifyListeners();
  }

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
    loading = true;
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
    for (final newImage in newImages) {
      if (images.contains(newImage)) {
        updateImages.add(newImage);
      } else {
        final StorageUploadTask task =
            storageRf.child(Uuid().v1()).putFile(newImage as File);
        final StorageTaskSnapshot snapshot = await task.onComplete;
        final String url = await snapshot.ref.getDownloadURL() as String;
        updateImages.add(url);
      }
    }

    for (final image in images) {
      if (!newImages.contains(image)) {
        try {
          final ref = await storage.getReferenceFromUrl(image);
          await ref.delete();
        } catch (e) {
          //ignore;
        }
      }
    }

    await firestoreRef.updateData({'images': updateImages});

    images = updateImages;
    loading = false;
  }

  List<Map<String, dynamic>> exportSizeList() {
    return sizes.map((size) => size.toMap()).toList();
  }
}
