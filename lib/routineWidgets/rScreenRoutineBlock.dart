import 'package:cmsc128_lab/utils/styles.dart';
import 'package:flutter/material.dart';

class RoutineBlock extends StatelessWidget{
  const RoutineBlock({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: FractionalOffset.center, 
       decoration: myBoxDecoration(),
       padding: EdgeInsets.symmetric(horizontal: 50,vertical: 20),
       
        child: Row(
          children: const[
            Icon(Icons.cases),
            SizedBox(width: 20),
            Column(
              children: [
                Text("Morning Routine"),
                Text("6:00 am - 7:00 am")
              ],
            ),
            Spacer(),
            Text("1hour")
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