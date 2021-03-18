import 'package:flutter/material.dart';
import 'package:loja/common/CustomDrawer/custom_drawer_header.dart';
import 'package:loja/common/CustomDrawer/drawer_tile.dart';
import 'package:loja/models/user_manager.dart';
import 'package:provider/provider.dart';

class CustmDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
              colors: [
                const Color.fromARGB(255, 203, 236, 241),
                Colors.white,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            )),
          ),
          ListView(
            children: [
              CustomDrawerHeader(),
              Divider(),
              DrawerTile(Icons.home, "Incio", 0),
              DrawerTile(Icons.list, "Produtos", 1),
              DrawerTile(Icons.playlist_add_check, "Meus Pedidos", 2),
              DrawerTile(Icons.location_on, "Lojas", 3),
              Consumer<UserManager>(
                builder: (_, userManager, __) {
                  if (userManager.admEnabled) {
                    return Column(
                      children: [
                        Divider(),
                        DrawerTile(Icons.supervised_user_circle, "Usuarios", 4),
                        DrawerTile(Icons.book_rounded, "Pedidos", 5),
                      ],
                    );
                  } else {
                    return Container();
                  }
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}
