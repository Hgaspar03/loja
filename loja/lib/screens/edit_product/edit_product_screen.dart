import 'package:flutter/material.dart';
import 'package:loja/models/products.dart';
import 'package:loja/screens/edit_product/components/images_form.dart';

class EditProductScreen extends StatelessWidget {
  const EditProductScreen(this.product);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Editar Anuncio"),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          ImageForm(product),
        ],
      ),
    );
  }
}
