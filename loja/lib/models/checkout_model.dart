import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja/models/cart_manager.dart';

class CheckoutManager extends ChangeNotifier {
  CartManager cartManager;

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  void updateCart(CartManager cartManager) {
    this.cartManager = cartManager;
  }

  void chackout() {
    _decrementStock();
    print(_getOrderId());
  }
}

void _decrementStock() {}

Future<int> _getOrderId() async {
  final ref = FirebaseFirestore.instance.doc('aux/orderCounter');
  final result = FirebaseFirestore.instance.runTransaction((tx) async {
    final doc = await tx.get(ref);

    final orderId = doc.data()['current'] as int;
    tx.update(ref, {'current': orderId + 1});
    return {'orderId': orderId};
  });

  return result.then((value) => value['orderId']) as int;
}
