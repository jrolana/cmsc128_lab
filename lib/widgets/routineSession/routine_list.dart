import 'package:cmsc128_lab/pages/routine_session.dart';
import 'package:flutter/material.dart';
import 'package:cmsc128_lab/widgets/routineWidgets/routine_creation_activity_block.dart';

class RoutineSessionList extends StatefulWidget{
  String routineID;
  RoutineSessionList(this.routineID, {super.key});
  @override
  State<RoutineSessionList> createState() => _RoutineSessionListState(routineID);

}

class _RoutineSessionListState extends State<RoutineSessionList>{
  String routineID;
  late List activityIDs;
  _RoutineSessionListState(this.routineID);

  @override
  void initState() {
    // TODO: implement initState
    activityIDs = getActivities();
    super.initState();
  }

  @override
  Widget build(BuildContext context){
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      children:[
    return ListView.separated(
      itemCount: activityIDs.length,
      itemBuilder: (context,index){
        return ListTile(
          title: ActivityBlock()

        );
      },
      separatorBuilder: (context,index){
        return const SizedBox(
          height: 10,
        );
      },

      ],
    );
  }

  List getActivities(){
    // TODO: Insert Query for activities in routine

    return [];
  }


}