import 'package:flutter/material.dart';

class ActivityBlock extends StatefulWidget {
  final String type = 'activity';

  State<ActivityBlock> createState() {
    return _ActivityBlockState();
  }
}

class _ActivityBlockState extends State<ActivityBlock> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {},
        child: ListTile(
          leading: Icon(Icons.add),
          title: Text('Activity Name'),
          trailing: Text('duration'),
        ));
  }
}
