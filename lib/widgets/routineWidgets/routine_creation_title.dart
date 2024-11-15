import 'package:cmsc128_lab/utils/styles.dart';
import 'package:flutter/material.dart';

class RCreationActivityName extends StatelessWidget{
  const RCreationActivityName({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: FractionalOffset.center, 
       decoration: myBoxDecoration(),
       padding: EdgeInsets.symmetric(horizontal: 50,vertical: 20),
       
        child: Column(
          children: const[
            Text("Long Title of Your Routine",style: TextStyle(fontWeight: FontWeight.bold,color:Colors.white),),
            Text("Routine Name", style: TextStyle(fontWeight: FontWeight.w100,color:Colors.white),),
          ],
        )


    );
  }
}

BoxDecoration myBoxDecoration() {
  return BoxDecoration(
    border: Border.all(color: StyleColor.tertiary),
    color:StyleColor.primary,
    borderRadius: BorderRadius.circular(8.0),
  );
}