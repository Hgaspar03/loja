import 'package:flutter/material.dart';
import 'package:loja/common/CustomDrawer/custom_drawer.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: CustmDrawer(),
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              flexibleSpace: FlexibleSpaceBar(
                title: Text('Loja do Helenio'),
                centerTitle: true,
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                height: 2000,
                width: 200,
              ),
            )
          ],
        ));
  }
}
