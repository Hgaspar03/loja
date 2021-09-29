import 'package:flutter/material.dart';
import 'package:loja/common/cart/components/cart_tile.dart';
import 'package:loja/common/empty_card.dart';
import 'package:loja/common/login_card.dart';
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
          if (cartManager.user == null) {
            return LoginCard();
          }

          if (cartManager.itens.isEmpty) {
            return EmptyCard(
              iconData: Icons.remove_shopping_cart,
              title: 'Nenhum Produto no Carrinho',
            );
          }
          return ListView(
            children: [
              Column(
                children: cartManager.itens
                    .map((cartProduct) => CartTile(cartProduct))
                    .toList(),
              ),
              PriceCard(
                  bottonText: 'Continuar para entrega',
                  onPressed: cartManager.isCartValid
                      ? () {
                          Navigator.of(context).pushNamed('/checkout');
                        }
                      : null)
            ],
          );
        },
      ),
    );
  }
}
