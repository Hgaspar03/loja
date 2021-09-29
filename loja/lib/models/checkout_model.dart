import 'package:flutter/material.dart';
import 'package:loja/models/cart_manager.dart';

class CheckoutManager extends ChangeNotifier {
  CartManager cartManager;

  void updateCart(CartManager cartManager) {
    this.cartManager = cartManager;
  }
}