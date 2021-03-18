import 'dart:io';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loja/models/products.dart';
import 'package:loja/screens/edit_product/components/image_source_sheet.dart';

class ImageForm extends StatelessWidget {
  final Product product;

  const ImageForm(this.product);

  @override
  Widget build(BuildContext context) {
    return FormField<List<dynamic>>(
      initialValue: List.from(product.images),
      builder: (state) {
        void onImageSelected(File file) {
          state.value.add(file);
          state.didChange(state.value);
          Navigator.of(context).pop();
        }

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
            }).toList()
              ..add(
                Stack(
                  fit: StackFit.expand,
                  children: [
                    Material(
                      color: Colors.grey[100],
                      child: IconButton(
                        iconSize: 54,
                        color: Theme.of(context).primaryColor,
                        icon: Icon(Icons.add_a_photo),
                        onPressed: () {
                          if (Platform.isAndroid)
                            showModalBottomSheet(
                              context: context,
                              builder: (_) => ImageSourceSheet(
                                onImageSelect: onImageSelected,
                              ),
                            );
                          else {
                            showCupertinoModalPopup(
                              context: context,
                              builder: (_) => ImageSourceSheet(
                                onImageSelect: onImageSelected,
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
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
