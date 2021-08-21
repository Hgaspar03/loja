import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CepInputField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var primaryColor = Theme.of(context).primaryColor;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextFormField(
          decoration: InputDecoration(
              isDense: true, labelText: 'CEP', hintText: '12.345-678'),
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
          ],
        ),
        RaisedButton(
          onPressed: () {},
          color: primaryColor,
          disabledColor: primaryColor.withAlpha(100),
          textColor: Colors.white,
          child: const Text(
            'Buscar CEP',
          ),
        )
      ],
    );
  }
}
