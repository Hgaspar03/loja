import 'package:flutter/material.dart';
import 'package:loja/common/custom_icon_button.dart';
import 'package:loja/models/iten_size.dart';
import 'package:loja/models/products.dart';
import 'package:loja/screens/edit_product/components/edit_item_size.dart';

class SizesForm extends StatelessWidget {
  final Product product;

  const SizesForm(this.product);

  @override
  Widget build(BuildContext context) {
    return FormField<List<ItemSize>>(
      initialValue: List.from(product.sizes),
      builder: (state) {
        return Column(children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Tamanhos',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ),
              CustonIconButton(
                color: Theme.of(context).primaryColor,
                iconData: Icons.add_circle,
                onTap: () {
                  state.value.add(ItemSize());
                  state.didChange(state.value);
                },
              ),
            ],
          ),
          Column(
            children: state.value.map(
              (size) {
                return EditItemSize(
                  size: size,
                  onRemove: () {
                    state.value.remove(size);
                    state.didChange(state.value);
                  },
                );
              },
            ).toList(),
          ),
        ]);
      },
    );
  }
}
