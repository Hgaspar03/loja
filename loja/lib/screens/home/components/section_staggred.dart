import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:loja/models/home_manager.dart';
import 'package:loja/models/section.dart';
import 'package:loja/screens/home/components/add_tile_widget.dart';
import 'package:loja/screens/home/components/item_tile.dart';
import 'package:loja/screens/home/components/section_header.dart';
import 'package:provider/provider.dart';

class SectionStaggred extends StatelessWidget {
  SectionStaggred(this.section);

  final Section section;

  @override
  Widget build(BuildContext context) {
    final homemanager = context.watch<HomeManager>();
    return Container(
      margin: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(section),
          StaggeredGridView.countBuilder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            crossAxisCount: 4,
            itemCount: homemanager.editing
                ? section.items.length + 1
                : section.items.length,
            itemBuilder: (_, index) {
              if (index < section.items.length)
                return ItemTile(section.items[index]);
              else
                return AddTileWidget();
            },
            staggeredTileBuilder: (index) {
              return StaggeredTile.count(2, index.isEven ? 2 : 1);
            },
            mainAxisSpacing: 4,
            crossAxisSpacing: 4,
          )
        ],
      ),
    );
  }
}
