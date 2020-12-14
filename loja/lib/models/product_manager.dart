import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:loja/models/products.dart';

class ProductManager extends ChangeNotifier {
  ProductManager() {
    _loadAllProducts();
  }

  Firestore _firestore = Firestore.instance;
  List<Product> allProducts = [];
  String _search = '';

  set search(String search) {
    _search = search;
    notifyListeners();
  }

  get search => _search;

  void _loadAllProducts() async {
    final QuerySnapshot snapProducts =
        await _firestore.collection('products').getDocuments();

    allProducts =
        snapProducts.documents.map((doc) => Product.fromDocument(doc)).toList();

    notifyListeners();
  }

  List<Product> get filteredProducts {
    final List<Product> filteredProducts = [];

    if (_search.isEmpty) {
      filteredProducts.addAll(allProducts);
    } else {
      filteredProducts.addAll(allProducts
          .where((p) => p.name.toLowerCase().contains(_search.toLowerCase())));
    }
    return filteredProducts;
  }
}
