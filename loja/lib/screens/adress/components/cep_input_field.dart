import 'package:brasil_fields/brasil_fields.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loja/models/cart_manager.dart';

class CepInputField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final prinaryColor = Theme.of(context).primaryColor;
    final cepTextController = TextEditingController();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextFormField(
          controller: cepTextController,
          decoration: const InputDecoration(
              isDense: true, labelText: 'CEP', hintText: '12.541-854'),
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            CepInputFormatter(),
          ],
          validator: (cep) {
            if (cep.isEmpty)
              return 'Campo obrigatrio';
            else if (cep.length > 10)
              return 'CEP invalido';
            else
              return null;
          },
          onChanged: (cep) => cep = cepTextController.text,
        ),
        ElevatedButton(
          onPressed: () {
            if (Form.of(context).validate()) {
              context.read<CartManager>().getAdress(cepTextController.text);
            }
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
                if (states.contains(MaterialState.disabled))
                  return prinaryColor.withAlpha(100);
                return prinaryColor;
              },
            ),
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
          ),
          child: const Text("Buscar CEP"),
        ),
      ],
    );
  }
}
