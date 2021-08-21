import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:loja/models/products.dart';

class ProductManager extends ChangeNotifier {
  ProductManager() {
    _loadAllProducts();
  }

  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Product> allProducts = [];
  String _search = '';

  set search(String search) {
    _search = search;
    notifyListeners();
  }

  get search => _search;

  void _loadAllProducts() async {
    final QuerySnapshot snapProducts =
        await _firestore.collection('products').get();

    allProducts =
        snapProducts.docs.map((doc) => Product.fromDocument(doc)).toList();

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

  Product findProductByID(String id) {
    try {
      return allProducts.firstWhere((p) => p.id == id);
    } catch (e) {
      return null;
    }
  }

  void update(Product product) {
    allProducts.removeWhere((p) => p.id == product.id);
    allProducts.add(product);
    notifyListeners();
  }
}
