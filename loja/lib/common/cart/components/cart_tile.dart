import 'package:flutter/material.dart';
import 'package:loja/models/cart_product.dart';
import 'package:loja/common/custom_icon_button.dart';

class CartTile extends StatelessWidget {
  const CartTile(this.cartProduct);

  final CartProduct cartProduct;

  @override
  Widget build(BuildContext context) {
    return Card(
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
                    Text(
                      '${cartProduct.unitPrice.toStringAsFixed(2)} MZN',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor),
                    )
                  ],
                ),
              ),
            ),
            Column(
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
                    color: Theme.of(context).primaryColor,
                    iconData: Icons.remove,
                    onTap: cartProduct.decrement),
              ],
            )
          ],
        ),
      ),
    );
  }
}
