import 'package:flutter/material.dart';
import 'package:loja/models/products.dart';

class ProductsListTile extends StatelessWidget {
  ProductsListTile({this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed('/product', arguments: product);
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        child: Container(
          height: 100,
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: Image.network(product.images.first),
              ),
              SizedBox(
                width: 8,
              ),
              Expanded(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      'A partir de',
                      style: TextStyle(color: Colors.grey[400], fontSize: 12),
                    ),
                  ),
                  Text(
                    '${product.basePrice.toStringAsFixed(2)} MTN',
                    style: TextStyle(
                        color: Theme.of(context).primaryColor, fontSize: 15),
                  ),
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
