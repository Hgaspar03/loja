import 'package:brasil_fields/brasil_fields.dart';
import 'package:loja/common/custom_icon_button.dart';
import 'package:loja/models/address.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loja/models/cart_manager.dart';

class CepInputField extends StatelessWidget {
  CepInputField(this.address);

  final Address address;

  final TextEditingController cepTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final prinaryColor = Theme.of(context).primaryColor;

    if (address.zipCode == null)
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            controller: cepTextController,
            decoration: const InputDecoration(
                isDense: true, labelText: 'CEP', hintText: '08.090-284'),
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              CepInputFormatter(),
            ],
            onChanged: (cep) => cep = cepTextController.text,
            validator: (cep) {
              if (cepTextController.text.isEmpty)
                return 'Campo obrigatrio';
              else if (cepTextController.text.length != 10)
                return 'CEP invalido';
              else
                return null;
            },
          ),
          ElevatedButton(
            onPressed: () {
              if (Form.of(context).validate())
                context
                    .read<CartManager>()
                    .getAdress(cepTextController.text)
                    .onError(
                      (error, _) => ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(error),
                          duration: Duration(seconds: 3),
                        ),
                      ),
                    );

              cepTextController.text = null;
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
    else
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Row(
          children: [
            Expanded(
              child: Text(
                'CEP: ${address.zipCode}',
                style:
                    TextStyle(fontWeight: FontWeight.w600, color: prinaryColor),
              ),
            ),
            CustonIconButton(
              color: prinaryColor,
              iconData: Icons.edit,
              size: 20.0,
              onTap: () {
                context.read<CartManager>().removeAddress();
              },
            )
          ],
        ),
      );
  }
}
