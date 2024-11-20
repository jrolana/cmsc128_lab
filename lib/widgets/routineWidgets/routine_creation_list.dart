// ignore_for_file: prefer_const_constructors

import 'package:cmsc128_lab/widgets/routineWidgets/routine_creation_activity_block.dart';
import 'package:flutter/material.dart';
class ActivitiesListReorderable extends StatefulWidget {
  const ActivitiesListReorderable({super.key});

  @override
  State<ActivitiesListReorderable> createState() => ReorderableList();
}

class ReorderableList extends State<ActivitiesListReorderable> {
  final List<int> _items = List<int>.generate(5, (int index) => index);

  @override
  Widget build(BuildContext context) {
    //final Color oddItemColor = colorScheme.primary.withOpacity(0.05);
    //final Color evenItemColor = colorScheme.primary.withOpacity(0.15);

    return ReorderableListView(
      shrinkWrap: true,
      children: <Widget>[
        for (int index = 0; index < _items.length; index += 1)
          Padding(
            padding: EdgeInsets.symmetric(vertical: 2.0),
            key: Key('$index'),
              child:ActivityButtonCreation()
          )
      ],
      onReorder: (int oldIndex, int newIndex) {
        setState(() {
          if (oldIndex < newIndex) {
            newIndex -= 1;
          }
          final int item = _items.removeAt(oldIndex);
          _items.insert(newIndex, item);
        });
      },
    );
  }
}
