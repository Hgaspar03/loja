import 'package:flutter/material.dart';
import 'package:loja/common/CustomDrawer/custom_drawer.dart';
import 'package:loja/models/user_manager.dart';
import 'package:loja/screens/admUsers/admin_users_screen.dart';
import 'package:loja/screens/home/home_screen.dart';
import 'package:loja/screens/products/products_screem.dart';
import 'package:provider/provider.dart';
import 'package:loja/models/page_manager.dart';

class BaseScreen extends StatelessWidget {
  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Provider(
        create: (_) => PagaManager(pageController),
        child: Consumer<UserManager>(
          builder: (_, usermanager, __) {
            return PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: pageController,
              children: [
                HomeScreen(),
                ProductsScreen(),
                Scaffold(
                  drawer: CustmDrawer(),
                  appBar: AppBar(
                    title: const Text("Meus Pedidos"),
                  ),
                ),
                Scaffold(
                  drawer: CustmDrawer(),
                  appBar: AppBar(
                    title: const Text("Lojas"),
                  ),
                ),
                if (usermanager.admEnabled) ...[
                  AdminUsersScreen(),
                  Scaffold(
                    drawer: CustmDrawer(),
                    appBar: AppBar(
                      title: const Text("Pedidos"),
                    ),
                  ),
                ]
              ],
            );
          },
        ));
  }
}
