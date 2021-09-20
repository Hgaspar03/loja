import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:loja/models/address.dart';
import 'package:loja/models/cart_product.dart';
import 'package:loja/models/products.dart';
import 'package:loja/models/user_manager.dart';
import 'package:loja/models/user.dart';
import 'package:loja/services/cepaberto_service.dart';

class CartManager extends ChangeNotifier {
  List<CartProduct> itens = [];

  num productsPrice = 0.0;

  LocalUser user;

  Address addres;

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
          .then((doc) => cartProduct.id = doc.id);
      _onItemUpdate();
    }
    notifyListeners();
  }

  Future<void> _loadCartItems() async {
    final QuerySnapshot cartSnap = await user.cartRef.get();
    itens = cartSnap.docs
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
    productsPrice = 0.0;
    for (var i = 0; i < itens.length; i++) {
      final cartProduct = itens[i];

      if (cartProduct.quantity == 0) {
        removeFromCart(cartProduct);
        i--;
        continue;
      }
      productsPrice += cartProduct.totalPrice;

      _updateCartProduct(cartProduct);
    }
  }

  void _updateCartProduct(CartProduct cartProduct) {
    if (cartProduct.id != null)
      user.cartRef.doc(cartProduct.id).update(cartProduct.toCartItemMap());
    notifyListeners();
  }

  void removeFromCart(CartProduct cartProduct) {
    itens.removeWhere((element) => element.id == cartProduct.id);
    user.cartRef.doc(cartProduct.id).delete();
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

  Future<void> getAdress(String cep) async {
    final cepAbertoService = CepAbertoService();

    final adress = await cepAbertoService.getAdressFromCEP(cep);

    if (adress != null) {
      this.addres = Address(
          street: adress.logradouro,
          district: adress.bairro,
          zipCode: adress.cep,
          city: adress.cidade.nome,
          state: adress.estado.sigla,
          lat: adress.latitude,
          long: adress.longitude);
    }

    notifyListeners();
  }
}
