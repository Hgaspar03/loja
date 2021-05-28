import 'package:flutter/material.dart';
import 'package:loja/screens/adress/components/cep_input_field.dart';

class AdressCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Endereco de Entrega",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            ),
            CepInputField(),
          ],
        ),
      ),
    );
  }
}
