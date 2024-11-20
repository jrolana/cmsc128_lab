import 'package:flutter/material.dart';
// import 'package:cmsc128_lab/utils/styles.dart';

class ActivityBlock extends StatefulWidget{
  const ActivityBlock({super.key});

  @override
  State<ActivityBlock> createState() => DefaultActivityBlock();


}

class DefaultActivityBlock extends State<ActivityBlock>{
  String actName = 'Default Name';
  int minDuration = 1;
  int hourDuration = 0;
  IconData actIcon = Icons.square_rounded;

  @override
  Widget build(BuildContext context){
    return ElevatedButton(
        onPressed: (){},
        child: Padding(
            padding: EdgeInsets.symmetric(vertical:10,horizontal: 20),
            child: Row(
          children: [
            Icon(actIcon),
            Expanded(
              child: Text(
                actName,
                textAlign: TextAlign.left,
              ),
            ),
            Row(
              children: [
                Text('$hourDuration hr'),
                Text('$minDuration min')
              ],
            )
          ],
        ))
    );
  }
}
class ActivityButtonCreation extends StatelessWidget{
  const ActivityButtonCreation({super.key});

  @override
  Widget build(BuildContext context){
    return ElevatedButton(
      onPressed: (){},
      child:Container (
        padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 20),
        child: Row(
        children: const[
          Expanded(
            child:Row(
            children: [
              Icon(Icons.bed),
              SizedBox(width:10),
              Text("Make bed",textAlign: TextAlign.left,),
            ],
          ),
          ),
          Row(
            children: [
              Icon(Icons.timer_sharp),
              Text('1min', textAlign: TextAlign.right,),
            ],

          ),
        ],

      ),
      ),
      
    );
  }
}