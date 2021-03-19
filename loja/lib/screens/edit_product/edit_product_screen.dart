import 'package:flutter/material.dart';
import 'package:loja/models/products.dart';
import 'package:loja/screens/edit_product/components/images_form.dart';

class EditProductScreen extends StatelessWidget {
  EditProductScreen(this.product);

  final Product product;

  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Editar Anuncio"),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: Form(
        key: formkey,
        child: ListView(
          children: [
            ImageForm(product),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    initialValue: product.name,
                    decoration: InputDecoration(
                      hintText: "Titulo",
                      border: InputBorder.none,
                    ),
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    validator: (name) {
                      if (name.length < 6) {
                        return "Titulo muito curto";
                      }
                      return null;
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      "A partir de",
                      style: TextStyle(color: Colors.grey[600], fontSize: 13),
                    ),
                  ),
                  Text(
                    "... Mt",
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16, bottom: 8),
                    child: Text(
                      "Descricao",
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 22,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  ElevatedButton(
                    style: ButtonStyle(),
                    onPressed: () {
                      if (formkey.currentState.validate()) {
                        print("Valido");
                      } else {
                        print("Invalido");
                      }
                    },
                    child: const Text("Salvar"),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
