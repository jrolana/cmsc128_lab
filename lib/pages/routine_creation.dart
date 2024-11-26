import 'package:cmsc128_lab/widgets/routineWidgets/routine_creation_list.dart';
import 'package:cmsc128_lab/widgets/routineWidgets/routine_creation_activity_block.dart';
import 'package:cmsc128_lab/widgets/routineWidgets/routine_creation_title.dart';
import 'package:cmsc128_lab/utils/styles.dart';
import 'package:flutter/material.dart';

class RoutineCreation extends StatefulWidget {
  const RoutineCreation({super.key});

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
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
            style: TextButton.styleFrom(backgroundColor: StyleColor.primary),
            onPressed:(){} , 
            child: Container(
              padding: EdgeInsets.all(8),
              color: StyleColor.primary,
              child: Text("Create Routine",style: TextStyle(color: Colors.white))
              ),),
            Container(
              padding: EdgeInsets.all(9),
              child:TextButton(
              onPressed: (){}, 
              style: TextButton.styleFrom(backgroundColor: StyleColor.primary),
              child: Icon(Icons.playlist_add_rounded,color: Colors.white,))
            ),
          ]
        ),
        appBar: AppBar(
          leading: const IconButton(
            icon: Icon(Icons.arrow_back),
            tooltip: 'Home',
            onPressed: null,
          ),
          title: const Text('Create a Routine'),
        ),
        body: const Padding(
          
          padding: EdgeInsets.fromLTRB(20,20,20,80),
            child:SingleChildScrollView(
            child:Column(
            children: [
            RCreationActivityName(),
            SizedBox(height:20),
            ReorderableExample(),
          ],
        ),), 
    ),
  ),
);
}
}