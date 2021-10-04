import 'package:flutter/material.dart';
import 'package:loja/common/price_card.dart';
import 'package:loja/models/cart_manager.dart';
import 'package:loja/models/checkout_model.dart';
import 'package:provider/provider.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cartManager = context.watch<CartManager>();

    return ChangeNotifierProxyProvider<CartManager, CheckoutManager>(
      create: (_) => CheckoutManager(),
      update: (_, cartManager, checkoutManager) =>
          checkoutManager..updateCart(cartManager),
      lazy: false,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Pagamento'),
        ),
        body: Consumer<CheckoutManager>(
          builder: (_, checkoutManager, __) {
            return ListView(
              children: [
                PriceCard(
                    bottonText: 'Finalizar Pagamento',
                    onPressed: cartManager.isAddressValid ? () {} : null)
              ],
            );
          },
        ),
      ),
    );
  }
}
