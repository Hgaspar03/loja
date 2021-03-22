import 'package:flutter/material.dart';
import 'package:loja/common/custom_icon_button.dart';
import 'package:loja/models/iten_size.dart';

class EditItemSize extends StatelessWidget {
  const EditItemSize(this.size);

  final ItemSize size;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(
        flex: 30,
        child: TextFormField(
          initialValue: size.name,
          decoration: InputDecoration(
            labelText: 'Tamanho',
            isDense: true,
          ),
        ),
      ),
      const SizedBox(
        width: 4,
      ),
      Expanded(
        flex: 30,
        child: TextFormField(
          initialValue: size.stock?.toString(),
          decoration: InputDecoration(
            labelText: 'Quantidade',
            isDense: true,
          ),
          keyboardType: TextInputType.number,
        ),
      ),
      const SizedBox(
        width: 4,
      ),
      Expanded(
        flex: 40,
        child: TextFormField(
          initialValue: size.price?.toStringAsFixed(2),
          decoration: InputDecoration(
            labelText: 'Preço',
            isDense: true,
            suffixText: 'Mt',
          ),
          keyboardType: TextInputType.number,
        ),
      ),
      CustonIconButton(
        color: Colors.black,
        iconData: Icons.arrow_drop_up,
      ),
      CustonIconButton(
        color: Colors.black,
        iconData: Icons.arrow_drop_down,
      ),
      CustonIconButton(
        color: Colors.red,
        iconData: Icons.remove,
      )
    ]);
  }
}
