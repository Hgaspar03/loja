import 'package:flutter/material.dart';
import 'package:loja/common/CustomDrawer/custom_drawer.dart';
import 'package:loja/screens/products/products_screem.dart';
import 'package:provider/provider.dart';
import 'package:loja/models/page_manager.dart';

class BaseScreen extends StatelessWidget {
  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => PagaManager(pageController),
      child: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        children: [
          Scaffold(
            drawer: CustmDrawer(),
            appBar: AppBar(
              title: Text("Helenio's Home"),
            ),
          ),
          ProductsScreen(),
          Container(
              color: Colors.red,
              child: Center(
                child: RaisedButton(
                  onPressed: () {
                    pageController.jumpToPage(0);
                  },
                  child: Text('Next'),
                ),
              )),
        ],
      ),
    );
  }
}
