import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RoutineBlock extends StatelessWidget{
  const RoutineBlock({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: Container(
      alignment: FractionalOffset.center, 
       decoration: myBoxDecoration(),
       padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
       margin: EdgeInsets.symmetric(horizontal: 20),
       
        child: Row(
          children: [
            Icon(Icons.cases_sharp, size:30, color: const Color.fromARGB(255, 25, 36, 108)),
            SizedBox(width: 20),
            Column(
              children: [
                Text("Morning Routine",style: GoogleFonts.lexendDeca(textStyle: TextStyle(fontWeight: FontWeight.bold,fontSize:14,))),
                Text("6:00 am - 7:00 am",style: GoogleFonts.lexendDeca(textStyle: TextStyle(color: const Color.fromARGB(255, 97, 97, 97), fontSize: 11)), textAlign: TextAlign.left,)
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
    border: Border.all(color: const Color.fromARGB(255, 255, 255, 255)),
    color:Color.fromARGB(255, 254, 254, 254),
    borderRadius: BorderRadius.circular(20.0),
  );
}