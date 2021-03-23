import 'package:flutter/material.dart';
import 'package:loja/common/custom_icon_button.dart';
import 'package:loja/models/iten_size.dart';

class EditItemSize extends StatelessWidget {
  const EditItemSize(
      {Key key, this.size, this.onRemove, this.onMoveUp, this.onMoveDown})
      : super(key: key);

  final ItemSize size;

  final VoidCallback onRemove;
  final VoidCallback onMoveUp;
  final VoidCallback onMoveDown;

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
          validator: (name) {
            if (name.isEmpty) return "Invalido";
            return null;
          },
          onChanged: (value) => size.name = value,
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
          validator: (stock) {
            if (int.tryParse(stock) == null) return "Invalida";
            return null;
          },
          onChanged: (value) => size.stock = int.tryParse(value),
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
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          validator: (price) {
            if (num.tryParse(price) == null) return "Invalido";
            return null;
          },
          onChanged: (value) => size.price = num.tryParse(value),
        ),
      ),
      CustonIconButton(
        color: Colors.black,
        iconData: Icons.arrow_drop_up,
        onTap: onMoveUp,
      ),
      CustonIconButton(
        color: Colors.black,
        iconData: Icons.arrow_drop_down,
        onTap: onMoveDown,
      ),
      CustonIconButton(
        color: Colors.red,
        iconData: Icons.remove,
        onTap: onRemove,
      )
    ]);
  }
}
