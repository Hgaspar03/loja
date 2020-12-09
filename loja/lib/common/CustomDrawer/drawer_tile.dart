import 'package:flutter/material.dart';
import 'package:loja/models/page_manager.dart';
import 'package:provider/provider.dart';

class DrawerTile extends StatelessWidget {
  const DrawerTile(this.iconData, this.titule, this.page);

  final IconData iconData;
  final String titule;
  final int page;

  @override
  Widget build(BuildContext context) {
    final int curPage = context.watch<PagaManager>().curPage;
    final Color primaryColr = Theme.of(context).primaryColor;

    return InkWell(
      onTap: () {
        context.read<PagaManager>().setpage(page);
      },
      child: SizedBox(
        height: 58,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Icon(
                iconData,
                size: 32,
                color: curPage == page ? primaryColr : Colors.black38,
              ),
            ),
            Text(
              titule,
              style: TextStyle(
                fontSize: 16,
                color: curPage == page ? primaryColr : Colors.black38,
              ),
            )
          ],
        ),
      ),
    );
  }
}
