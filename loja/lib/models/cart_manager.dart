import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
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

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  num deliveryPrice = 0.0;
  bool _loading = false;

  num get totalPrice => productsPrice + (this.deliveryPrice ?? 0);
  bool get loading => _loading;

  set loading(bool isLoading) {
    _loading = isLoading;
    notifyListeners();
  }

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
    productsPrice = 0.0;
    user = userMnanager.user;
    itens.clear();
    removeAddress();

    if (user != null) {
      _loadCartItems();
      _loadUserAddress();
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

  bool get isAddressValid => addres != null && deliveryPrice != null;

  Future<void> getAdress(String cep) async {
    loading = true;

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

    loading = false;
  }

  void removeAddress() {
    addres = null;
    deliveryPrice = null;
    notifyListeners();
  }

  void setAddress(Address address) async {
    user.setAddress(address);
    loading = true;
    this.addres = address;
    if (await calculateDelivery(address.lat, address.long)) {
      loading = false;
    } else {
      loading = false;
      return Future.error('Endereço fora do raio de entrega :(');
    }
  }

  Future<bool> calculateDelivery(double lat, double long) async {
    final DocumentSnapshot doc = await firestore.doc('aux/delivery').get();

    final double latStore = doc.data()['lat'] as double;
    final double longStore = doc.data()['long'] as double;
    final num maxKm = doc.data()['maxkm'] as num;
    final num base = doc.data()['base'] as num;
    final num km = doc.data()['km'] as num;

    double dis =
        await Geolocator().distanceBetween(latStore, longStore, lat, long);

    dis /= 1000.0;

    if (dis <= maxKm) return false;
    deliveryPrice = base + dis * km;
    return true;
  }

  Future<void> _loadUserAddress() async {
    if (user.address != null &&
        await calculateDelivery(user.address.lat, user.address.long)) {
      this.addres = user.address;
      notifyListeners();
    }
  }
}
