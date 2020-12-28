import 'package:flutter/material.dart';
import 'package:loja/models/cart_product.dart';
import 'package:loja/common/custom_icon_button.dart';
import 'package:provider/provider.dart';

class CartTile extends StatelessWidget {
  const CartTile(this.cartProduct);

  final CartProduct cartProduct;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: cartProduct,
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              SizedBox(
                height: 80,
                width: 80,
                child: Image.network(cartProduct.product.images.first),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(left: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        cartProduct.product.name,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 17,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Text(
                          'Tamanho ${cartProduct.size}',
                          style: TextStyle(fontWeight: FontWeight.w300),
                        ),
                      ),
                      Consumer<CartProduct>(builder: (_, cartProduct, __) {
                        if (cartProduct.hasStrock()) {
                          return Text(
                            '${cartProduct.unitPrice.toStringAsFixed(2)} MZN',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).primaryColor),
                          );
                        } else {
                          return Text(
                            'Quantidade indisponível',
                            style: TextStyle(color: Colors.red, fontSize: 12),
                          );
                        }
                      })
                    ],
                  ),
                ),
              ),
              Consumer<CartProduct>(builder: (_, cartProduct, __) {
                return Column(
                  children: [
                    CustonIconButton(
                      color: Theme.of(context).primaryColor,
                      iconData: Icons.add,
                      onTap: cartProduct.increment,
                    ),
                    Text(
                      '${cartProduct.quantity}',
                      style: TextStyle(fontSize: 20),
                    ),
                    CustonIconButton(
                        color: cartProduct.quantity > 1
                            ? Theme.of(context).primaryColor
                            : Colors.red,
                        iconData: Icons.remove,
                        onTap: cartProduct.decrement),
                  ],
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
