import 'package:flutter/material.dart';
import 'package:alphabet_list_scroll_view/alphabet_list_scroll_view.dart';
import 'package:loja/common/CustomDrawer/custom_drawer.dart';
import 'package:loja/models/admin_users_manager.dart';
import 'package:provider/provider.dart';

class AdminUsersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustmDrawer(),
      appBar: AppBar(
        title: const Text("Usuarios"),
        centerTitle: true,
      ),
      body: Consumer<AdminUsersManager>(
        builder: (_, adminUsermanager, __) {
          return Card(
            color: Colors.white,
            margin: EdgeInsets.all(10),
            elevation: 40,
            borderOnForeground: true,
            shadowColor: Colors.black,
            child: AlphabetListScrollView(
              itemBuilder: (_, index) {
                return ListTile(
                  title: Text(
                    adminUsermanager.users[index].nome,
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w800),
                  ),
                  subtitle: Text(
                    adminUsermanager.users[index].email,
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                );
              },
              indexedHeight: (index) => 80,
              highlightTextStyle: TextStyle(
                  fontSize: 25, color: Theme.of(context).primaryColor),
              strList: adminUsermanager.names,
              showPreview: true,
            ),
          );
        },
      ),
    );
  }
}
