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

  Future<void> checkout(
      {Function onStockFail,
      Function onStockSucess,
      CartManager cartManager}) async {
    cartManager.loading = true;
    try {
      await _decrementStock();
    } catch (e) {
      onStockFail(e);
      cartManager.loading = false;
    }

    _getOrderId();
    cartManager.loading = false;
    onStockSucess();
  }

  Future<void> _decrementStock() async {
    this.cartManager = cartManager;

    return firestore.runTransaction(
      (tx) async {
        final List<Product> productToUpdate = [];
        final List<Product> productWithoutStock = [];

        for (final cartProduct in this.cartManager.itens) {
          Product product;

          if (productToUpdate.any((p) => p.id == cartProduct.productId)) {
            product = productToUpdate
                .firstWhere((p) => p.id == cartProduct.productId);
          } else {
            final doc = await tx
                .get(firestore.doc('products/${cartProduct.productId}'));

            product = Product.fromDocument(doc);
          }
          cartProduct.product = product;

          final size = product.findSize(cartProduct.size);
          if (size.stock - cartProduct.quantity < 0) {
            productWithoutStock.add(product);
          } else {
            size.stock -= cartProduct.quantity;
            productToUpdate.add(product);
          }
        }

        if (productWithoutStock.isNotEmpty) {
          return Future.error(
              '${productWithoutStock.length} produtos sem estoque');
        }
        for (final product in productToUpdate) {
          tx.update(firestore.doc('products/${product.id}'),
              {'sizes': product.exportSizeList()});
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

      return await result.then((value) async => value['orderId']);
    } on FirebaseException {
      return Future.error('Erro ao gerar numero de pedido');
    }
  }
}
