import 'package:flutter/material.dart';
import 'package:loja/screens/adress/components/adress_card.dart';

class AdressScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Entrega"),
        centerTitle: true,
      ),
      body: ListView(
        children: [AdressCard()],
      ),
    );
  }
}
