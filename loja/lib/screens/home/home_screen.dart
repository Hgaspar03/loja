import 'package:flutter/material.dart';

import 'package:loja/common/CustomDrawer/custom_drawer.dart';
import 'package:loja/models/home_manager.dart';
import 'package:loja/screens/home/components/section_list.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustmDrawer(),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: const [
                Color.fromARGB(255, 211, 118, 130),
                Color.fromARGB(255, 253, 181, 168)
              ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
            ),
          ),
          CustomScrollView(
            slivers: [
              SliverAppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                snap: true,
                floating: true,
                flexibleSpace: const FlexibleSpaceBar(
                  title: Text("Loja do Helenio"),
                  centerTitle: true,
                ),
                actions: [
                  IconButton(
                    icon: Icon(
                      Icons.shopping_cart,
                      color: Colors.white,
                    ),
                    onPressed: () => Navigator.of(context).pushNamed('/cart'),
                  )
                ],
              ),
              Consumer<HomeManager>(builder: (_, homeManager, __) {
                final List<Widget> clildren =
                    homeManager.sections.map<Widget>((section) {
                  switch (section.type) {
                    case 'List':
                      return SectionList(section);
                    case 'Staggered':
                      return Container();
                    default:
                      return Container();
                  }
                }).toList();
                return SliverList(
                  delegate: SliverChildListDelegate(clildren),
                );
              })
            ],
          ),
        ],
      ),
    );
  }
}
