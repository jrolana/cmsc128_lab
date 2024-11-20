import 'package:cmsc128_lab/widgets/routineWidgets/routine_creation_list.dart';
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
            onPressed:(){
            } ,
            child: Container(
              padding: const EdgeInsets.all(8),
              color: StyleColor.primary,
              child: const Text("Create Routine",style: TextStyle(color: Colors.white))
              ),),
            Container(
              padding: const EdgeInsets.all(9),
              child:TextButton(
              onPressed: (){}, 
              style: TextButton.styleFrom(backgroundColor: StyleColor.primary),
              child: const Icon(Icons.playlist_add_rounded,color: Colors.white,))
            ),
          ]
        ),
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            tooltip: 'Home',
            onPressed: (){
              Navigator.pop(context);
            },
          ),
          title: const Text('Create a Routine'),
        ),
        body: Padding(
          
          padding: const EdgeInsets.fromLTRB(20,20,20,80),
            child:SingleChildScrollView(
            child:Column(
            children: const [
            RCreationActivityName(),
            SizedBox(height:20),
            ActivitiesListReorderable(),
          ],
        ),), 
    ),
  ),
);
}
}