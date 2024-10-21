import 'package:flutter/material.dart';

class RCreationActivityName extends StatelessWidget{
  const RCreationActivityName({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 600,
      padding: const EdgeInsets.all(8.0),
      decoration: myBoxDecoration(),
      child: Column(
        children: const [
          Text("Morning Routine"),
          Text("Routine Name"),
        ],
      ),
    );
  }
}

BoxDecoration myBoxDecoration() {
  return BoxDecoration(
    border: Border.all(),
  );
}