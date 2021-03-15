import 'package:flutter/material.dart';
import 'package:loja/models/section.dart';
import 'package:loja/screens/home/components/item_tile.dart';
import 'package:loja/screens/home/components/section_header.dart';

class SectionList extends StatelessWidget {
  SectionList(this.section);

  final Section section;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(section),
          SizedBox(
            height: 150,
            child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (_, index) => ItemTile(section.items[index]),
                separatorBuilder: (_, __) => const SizedBox(
                      width: 4,
                    ),
                itemCount: section.items.length),
          )
        ],
      ),
    );
  }
}
