import 'package:cmsc128_lab/routineWidgets/rCrerationActivityButton.dart';
import 'package:cmsc128_lab/routineWidgets/rCreationActivityName.dart';
import 'package:flutter/material.dart';

class RoutineCreation extends StatefulWidget {
  RoutineCreation({super.key});

  @override
  State<RoutineCreation> createState() {
    return _RoutineCreationDefaultState();
  }

}

class _RoutineCreationDefaultState extends State<RoutineCreation> with TickerProviderStateMixin{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: const IconButton(
            icon: Icon(Icons.arrow_back),
            tooltip: 'Home',
            onPressed: null,
          ),
          title: const Text('Create a Routine'),
        ),
        body: Column(
          children: const [
            RCreationActivityName(),
            ActivityButtonCreation(),
          ],
        )
      )
    );
  }
}