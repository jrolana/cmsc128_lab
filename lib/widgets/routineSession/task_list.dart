import 'package:cmsc128_lab/utils/firestore_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RoutineTaskList extends StatefulWidget{
    List? tasks;
    Function? doTask;
    Function? undoTask;
    RoutineTaskList(this.tasks,this.doTask,this.undoTask, {super.key});

    @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
      return _StateRoutineTaskList();
  }
}
class _StateRoutineTaskList extends State<RoutineTaskList>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
      return ListView.separated(itemBuilder: (context,index){
        bool checked = false;
        return ListTile(
          leading: Checkbox(value: checked, onChanged: (bool){
            checked = !checked;
          }),
        );
      }, separatorBuilder: (context,index){
        return SizedBox(height: MediaQuery.of(context).size.height * 0.01);
      }, itemCount:1);
    // return PageView.builder(
    //     itemCount: widget.tasks?.length,
    //     itemBuilder: (context,index){
    //   String taskName = FirestoreUtils.getTaskName(widget.tasks?[index]).toString();
    //   return SizedBox(
    //     height: 10,
    //     width: 10,
      //);

  }
}