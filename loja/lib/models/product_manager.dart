import 'package:cloud_firestore/cloud_firestore.dart';

class ProductManager {
  ProductManager() {
    _loadAllProducts();
  }

  Firestore _firestore = Firestore.instance;

  void _loadAllProducts() async {
    final QuerySnapshot snapProducts =
        await _firestore.collection('products').getDocuments();

    for (var doc in snapProducts.documents) {
      print(doc.data);
    }
  }
}
