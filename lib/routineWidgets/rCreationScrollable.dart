// ignore_for_file: prefer_const_constructors

import 'package:cmsc128_lab/routineWidgets/rCrerationActivityButton.dart';
import 'package:cmsc128_lab/routineWidgets/rCreationActivityName.dart';
import 'package:flutter/material.dart';
class ReorderableExample extends StatefulWidget {
  const ReorderableExample({super.key});

  @override
  State<ReorderableExample> createState() => _ReorderableListViewExampleState();
}

class _ReorderableListViewExampleState extends State<ReorderableExample> {
  final List<int> _items = List<int>.generate(5, (int index) => index);

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final Color oddItemColor = colorScheme.primary.withOpacity(0.05);
    final Color evenItemColor = colorScheme.primary.withOpacity(0.15);

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
