import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loja/models/address.dart';

class AddressInputField extends StatelessWidget {
  const AddressInputField(this.address);

  final Address address;

  @override
  Widget build(BuildContext context) {
    String emptyValidator(String text) =>
        text.isEmpty ? 'Campo obrigatório' : null;

    final primaryColor = Theme.of(context).primaryColor;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextFormField(
          initialValue: address.street,
          decoration: const InputDecoration(
            isDense: true,
            labelText: 'Rua/Avenida',
            hintText: 'Avenida Grande Manica',
          ),
          validator: emptyValidator,
          onSaved: (t) => address.street = t,
        ),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                initialValue: address.number,
                decoration: const InputDecoration(
                    isDense: true, labelText: 'Número', hintText: '1222125'),
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                keyboardType: TextInputType.number,
                validator: emptyValidator,
                onSaved: (t) => address.number = t,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: TextFormField(
                initialValue: address.complement,
                decoration: const InputDecoration(
                    isDense: true,
                    labelText: 'Complemento',
                    hintText: 'Opcional'),
                onSaved: (t) => address.number = t,
              ),
            ),
          ],
        ),
        TextFormField(
          initialValue: address.district,
          decoration: const InputDecoration(
            isDense: true,
            labelText: 'Bairro',
            hintText: 'Alto Mae',
          ),
          validator: emptyValidator,
          onSaved: (t) => address.district = t,
        ),
        Row(
          children: [
            Expanded(
              flex: 3,
              child: TextFormField(
                enabled: false,
                initialValue: address.city,
                decoration: const InputDecoration(
                  isDense: true,
                  labelText: 'Cidade',
                  hintText: 'Maputo',
                ),
                validator: emptyValidator,
              ),
            ),
            SizedBox(
              width: 16,
            ),
            Expanded(
              child: TextFormField(
                autocorrect: false,
                enabled: false,
                textCapitalization: TextCapitalization.characters,
                initialValue: address.state,
                decoration: const InputDecoration(
                  isDense: true,
                  labelText: 'MC',
                  hintText: 'MC',
                  counterText: '',
                ),
                maxLength: 2,
                validator: (e) {
                  if (e.isEmpty) {
                    return 'Campo Obrigatório';
                  } else if (e.length != 2) {
                    return 'Inválido';
                  }
                  return null;
                },
                onSaved: (t) => address.state = t,
              ),
            ),
          ],
        ),
        const SizedBox(
          width: 8,
        ),
        ElevatedButton(
          onPressed: () {},
          child: const Text('Calcular Frete'),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
                if (states.contains(MaterialState.disabled))
                  return primaryColor.withAlpha(100);
                return primaryColor;
              },
            ),
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
          ),
        )
      ],
    );
  }
}
