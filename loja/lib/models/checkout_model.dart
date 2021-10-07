import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:loja/models/cart_manager.dart';
import 'package:loja/models/products.dart';

class CheckoutManager extends ChangeNotifier {
  CartManager cartManager;

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  void updateCart(CartManager cartManager) {
    this.cartManager = cartManager;
  }

  void checkout() async {
    _decrementStock();
    print(await _getOrderId());
  }

  void _decrementStock() async {
    this.cartManager = cartManager;

    firestore.runTransaction(
      (tx) async {
        final List<Product> productToUpdate = [];
        for (final cartProduct in this.cartManager.itens) {
          final doc = await tx.get(
            firestore.doc('products/${cartProduct.productId}'),
          );

          final product = Product.fromDocument(doc);

          final size = product.findSize(cartProduct.size);
          if (size.stock - cartProduct.quantity < 0) {
          } else {
            size.stock -= cartProduct.quantity;
            productToUpdate.add(product);
          }
        }
      },
    );
  }

  Future<int> _getOrderId() async {
    try {
      final ref = firestore.doc('aux/orderCounter');
      final result = firestore.runTransaction((tx) async {
        final doc = await tx.get(ref);

        final orderId = doc.data()['current'] as int;
        tx.update(ref, {'current': orderId + 1});
        return {'orderId': orderId};
      }, timeout: Duration(seconds: 10));

      return result.then((value) => value['orderId']) as int;
    } catch (e) {
      debugPrint(e.toString());
      return Future.error('Erro ao gerar numero de pedido');
    }
  }
}
