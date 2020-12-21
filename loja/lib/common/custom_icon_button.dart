import 'package:flutter/material.dart';

class CustonIconButton extends StatelessWidget {
  CustonIconButton({this.iconData, this.color, this.onTap});
  final IconData iconData;
  final VoidCallback onTap;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(50),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.all(5),
            child: Icon(
              iconData,
              color: color,
            ),
          ),
        ),
      ),
    );
  }
}
