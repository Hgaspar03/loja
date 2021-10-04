import 'package:flutter/material.dart';
import 'package:loja/common/price_card.dart';
import 'package:loja/models/cart_manager.dart';
import 'package:loja/screens/adress/components/adress_card.dart';
import 'package:provider/provider.dart';

class AdressScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Entrega"),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          AdressCard(),
          Consumer<CartManager>(
            builder: (_, cartManager, __) {
              return PriceCard(
                bottonText: 'Continuar para o pagamento',
                onPressed: cartManager.isAddressValid
                    ? () {
                        Navigator.of(context).pushNamed('/checkout');
                      }
                    : null,
              );
            },
          ),
        ],
      ),
    );
  }
}
