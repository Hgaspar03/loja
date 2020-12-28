import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:loja/models/cart_product.dart';
import 'package:loja/models/products.dart';
import 'package:loja/models/user.dart';
import 'package:loja/models/user_manager.dart';

class CartManager extends ChangeNotifier {
  List<CartProduct> itens = [];

  num productsPrice = 0.0;

  User user;

  addToCart(Product product) {
    try {
      final e = itens.firstWhere((e) => e.stackeble(product));
      e.increment();
    } catch (e) {
      final cartProduct = CartProduct.fromProduct(product);
      cartProduct..addListener(_onItemUpdate);
      itens.add(cartProduct);

      user.cartRef
          .add(cartProduct.toCartItemMap())
          .then((doc) => cartProduct.id = doc.documentID);
    }
  }

  Future<void> _loadCartItems() async {
    final QuerySnapshot cartSnap = await user.cartRef.getDocuments();
    itens = cartSnap.documents
        .map((d) => CartProduct.fromDcument(d)..addListener(_onItemUpdate))
        .toList();
  }

  updateUser(UserManager userMnanager) {
    user = userMnanager.user;
    itens.clear();

    if (user != null) {
      _loadCartItems();
    }
  }

  _onItemUpdate() {
    for (final cartProduct in itens) {
      if (cartProduct.quantity == 0) {
        removeFromCart(cartProduct);
      }
      _updateCartProduct(cartProduct);
    }
  }

  void _updateCartProduct(CartProduct cartProduct) {
    user.cartRef
        .document(cartProduct.id)
        .updateData(cartProduct.toCartItemMap());
    notifyListeners();
  }

  void removeFromCart(CartProduct cartProduct) {
    itens.removeWhere((element) => element.id == cartProduct.id);
    user.cartRef.document(cartProduct.id).delete();
    cartProduct.removeListener(_onItemUpdate);
    notifyListeners();
  }

  bool get isCartValid {
    for (var cartProduct in itens) {
      if (!cartProduct.hasStrock()) {
        return false;
      }
    }
    return true;
  }
}
