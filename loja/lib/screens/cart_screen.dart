import 'package:flutter/material.dart';
import 'package:loja/common/cart/components/cart_tile.dart';
import 'package:loja/common/price_card.dart';
import 'package:loja/models/cart_manager.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carrinho'),
        centerTitle: true,
      ),
      body: Consumer<CartManager>(
        builder: (_, cartManager, __) {
          return ListView(
            children: [
              Column(
                children: cartManager.itens
                    .map((cartProduct) => CartTile(cartProduct))
                    .toList(),
              ),
              PriceCard('Continuar para entrega',
                  cartManager.isCartValid ? () {} : null)
            ],
          );
        },
      ),
    );
  }
}
