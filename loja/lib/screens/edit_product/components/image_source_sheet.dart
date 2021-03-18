import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ImageSourceSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      return BottomSheet(
        onClosing: () {},
        builder: (context) => Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextButton(
              onPressed: () {},
              child: const Text("Camera"),
            ),
            Divider(),
            TextButton(
              onPressed: () {},
              child: const Text("Galeria"),
            )
          ],
        ),
      );
    } else {
      return CupertinoActionSheet(
        cancelButton: CupertinoActionSheetAction(
          child: const Text("Cancelar"),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text("Selecionar foto para o item"),
        message: const Text("Escolha a origem da foto"),
        actions: [
          CupertinoActionSheetAction(
            isDefaultAction: true,
            onPressed: () {},
            child: const Text("Camera"),
          ),
          CupertinoActionSheetAction(
            onPressed: () {},
            child: const Text("Galeria"),
          ),
        ],
      );
    }
  }
}
