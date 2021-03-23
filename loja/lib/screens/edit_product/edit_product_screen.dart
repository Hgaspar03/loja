import 'package:flutter/material.dart';
import 'package:loja/models/products.dart';
import 'package:loja/screens/edit_product/components/images_form.dart';
import 'package:loja/screens/edit_product/components/sizes_form.dart';

class EditProductScreen extends StatelessWidget {
  EditProductScreen(Product p)
      : editing = p != null,
        product = p != null ? p.clone() : Product();

  final Product product;

  final bool editing;

  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(editing ? 'Editar Produto' : 'Criar Produto'),
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
                    onSaved: (name) => product.name = name,
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
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ),
                  TextFormField(
                    initialValue: product.description,
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                    decoration: const InputDecoration(
                        hintText: "Descricao", border: InputBorder.none),
                    maxLines: null,
                    validator: (desc) {
                      if (desc.length < 10) {
                        return 'Descricao muito curta';
                      }
                      return null;
                    },
                    onSaved: (desc) => product.description = desc,
                  ),
                  SizesForm(product),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                          return Theme.of(context)
                              .primaryColor
                              .withOpacity(0.6);
                        },
                      ),
                    ),
                    onPressed: () {
                      if (formkey.currentState.validate()) {
                        formkey.currentState.save();
                        product.save();
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
