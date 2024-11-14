import 'package:cmsc128_lab/utils/styles.dart';
import 'package:flutter/material.dart';

class RoutineBlock extends StatelessWidget{
  const RoutineBlock({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Container(
      alignment: FractionalOffset.center, 
       decoration: myBoxDecoration(),
       padding: EdgeInsets.symmetric(horizontal: 15,vertical: 20),
       
        child: Row(
          children: const[
            Icon(Icons.cases_outlined, size:30),
            SizedBox(width: 20),
            Column(
              children: [
                Text("Morning Routine",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18.0)),
                Text("6:00 am - 7:00 am",style: TextStyle(fontWeight: FontWeight.w200),)
              ],
            ),
            Spacer(),
            Text("1hour")
          ],
        )


    ),
    );
  }
}

BoxDecoration myBoxDecoration() {
  return BoxDecoration(
    border: Border.all(color: const Color.fromARGB(255, 222, 220, 231)),
    color:Color.fromARGB(255, 227, 214, 255),
    borderRadius: BorderRadius.circular(8.0),
  );
}