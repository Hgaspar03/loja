import 'package:flutter/material.dart';
import 'package:loja/screens/adress/component/adress_card.dart';

class AdressScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Entregas'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          AdressCartd(),
        ],
      ),
    );
  }
}
