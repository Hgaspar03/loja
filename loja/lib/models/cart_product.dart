import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:loja/models/iten_size.dart';
import 'package:loja/models/products.dart';

class CartProduct extends ChangeNotifier {
  CartProduct.fromProduct(this.product) {
    productId = product.id;
    quantity = 1;
    size = product.selectedSize.name;
  }

  String id;
  Product product;
  String productId;
  int quantity;
  String size;

  final firestore = FirebaseFirestore.instance;

  ItemSize get itemSize {
    return product == null ? null : product.findSize(size);
  }

  num get unitPrice {
    return product == null ? 0 : itemSize?.price ?? 0;
  }

  num get totalPrice => unitPrice * quantity;

  CartProduct.fromDcument(DocumentSnapshot d) {
    id = d.id;
    productId = d.data()['pid'] as String;
    quantity = d.data()['quantity'] as int;
    size = d.data()['size'] as String;

    firestore.document('products/$productId').get().then((d) {
      product = Product.fromDocument(d);
      notifyListeners();
    });
  }

  Map<String, dynamic> toCartItemMap() {
    return {'pid': productId, 'quantity': quantity, 'size': size};
  }

  stackeble(Product product) {
    return productId == product.id && product.selectedSize.name == size;
  }

  void increment() {
    quantity++;
    notifyListeners();
  }

  void decrement() {
    quantity--;
    notifyListeners();
  }

  bool hasStrock() {
    final size = itemSize;

    if (size == null) return false;

    return size.stock >= quantity;
  }
}
