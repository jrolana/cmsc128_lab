// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

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