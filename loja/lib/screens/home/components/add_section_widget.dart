import 'package:flutter/material.dart';
import 'package:loja/models/home_manager.dart';
import 'package:loja/models/section.dart';

class AddSectionWidget extends StatelessWidget {
  final HomeManager homemanager;

  const AddSectionWidget({Key key, this.homemanager}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: FlatButton(
            onPressed: () {
              homemanager.addSection(Section(type: 'List'));
            },
            child: const Text('Adicionar Lista'),
            textColor: Colors.white,
          ),
        ),
        Expanded(
          child: FlatButton(
            onPressed: () {
              homemanager.addSection(Section(type: 'Staggered'));
            },
            child: const Text('Adicionar Grade'),
            textColor: Colors.white,
          ),
        ),
      ],
    );
  }
}
