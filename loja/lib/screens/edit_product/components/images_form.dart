import 'dart:io';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:loja/models/products.dart';

class ImageForm extends StatelessWidget {
  final Product product;

  const ImageForm(this.product);

  @override
  Widget build(BuildContext context) {
    return FormField<List<dynamic>>(
      initialValue: product.images,
      builder: (state) {
        return AspectRatio(
          aspectRatio: 1,
          child: Carousel(
            images: state.value.map((image) {
              return Stack(
                fit: StackFit.expand,
                children: [
                  if (image is String)
                    Image.network(
                      image,
                      fit: BoxFit.cover,
                    )
                  else
                    Image.file(image as File, fit: BoxFit.cover),
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                        onPressed: () {
                          state.value.remove(image);
                          state.didChange(state.value);
                        },
                        icon: Icon(Icons.remove)),
                  )
                ],
              );
            }).toList(),
            dotSize: 6,
            dotColor: Theme.of(context).primaryColor,
            dotBgColor: Colors.transparent,
            autoplay: false,
            dotSpacing: 15,
          ),
        );
      },
    );
  }
}
