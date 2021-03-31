import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loja/screens/edit_product/components/image_source_sheet.dart';

class AddTileWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    void onImageSelect(File file) {}

    return AspectRatio(
      aspectRatio: 1,
      child: GestureDetector(
        onTap: () {
          if (Platform.isAndroid) {
            showModalBottomSheet(
                context: context,
                builder: (context) {
                  return ImageSourceSheet(onImageSelect: onImageSelect);
                });
          } else {
            showCupertinoModalPopup(
                context: context,
                builder: (context) {
                  return ImageSourceSheet(onImageSelect: onImageSelect);
                });
          }
        },
        child: Container(
          color: Colors.white.withAlpha(30),
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
