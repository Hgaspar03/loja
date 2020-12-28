import 'package:loja/models/iten_size.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:loja/models/products.dart';

class SizeWidget extends StatelessWidget {
  SizeWidget({this.size});

  final ItemSize size;

  @override
  Widget build(BuildContext context) {
    Color color;
    Product product = context.watch<Product>();
    bool selected = size == product.selectedSize;

    if (!size.hasStock) {
      color = Colors.red.withAlpha(90);
    } else if (selected) {
      color = Theme.of(context).primaryColor;
    } else {
      color = Colors.grey;
    }

    return GestureDetector(
      onTap: () {
        if (size.hasStock) product.selectedSize = size;
      },
      child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: size.hasStock ? Colors.grey : Colors.red.withAlpha(50),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                color: color,
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                child: Text(
                  size.name,
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  '${size.price.toStringAsFixed(2)} MZN',
                  style: TextStyle(color: color),
                ),
              )
            ],
          )),
    );
  }
}
