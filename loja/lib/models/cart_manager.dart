import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loja/models/cart_product.dart';
import 'package:loja/models/products.dart';
import 'package:loja/models/user.dart';
import 'package:loja/models/user_manager.dart';

class CartManager {
  List<CartProduct> itens = [];

  User user;

  addToCart(Product product) {
    try {
      final e = itens.firstWhere((e) => e.stackeble(product));
      e.quantity++;
    } catch (e) {
      final cartProduct = CartProduct.fromProduct(product);
      itens.add(cartProduct);

      user.cartRef.add(cartProduct.toCartItemMap());
    }
  }

  void _loadCartItems() async {
    final QuerySnapshot cartSnap = await user.cartRef.getDocuments();
    itens = cartSnap.documents.map((d) => CartProduct.fromDcument(d)).toList();
  }

  updateUser(UserManager userMnanager) {
    user = userMnanager.user;
    itens.clear();

    if (user != null) {
      _loadCartItems();
    }
  }
}
