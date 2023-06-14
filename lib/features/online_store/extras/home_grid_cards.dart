import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

import '../grid_items.dart';

class HomeGridCards extends StatelessWidget {
  const HomeGridCards({Key? key, required this.gridItems}) : super(key: key);
  final GridItems gridItems;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, '/${gridItems.title}');
            },
            child: Image(
              image: AssetImage(
                gridItems.icon.toString(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: AutoSizeText(
              gridItems.title.toString(),
              maxLines: 1,
              minFontSize: 10,
              stepGranularity: 10,
            ),
          ),
        ],
      ),
    );
  }
}
