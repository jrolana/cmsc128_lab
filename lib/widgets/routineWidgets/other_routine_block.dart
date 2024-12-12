import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cmsc128_lab/models/routine.dart';
import 'package:cmsc128_lab/service/Experimental_routine_db_service.dart';
import 'package:cmsc128_lab/widgets/routineWidgets/routine_home_routine_block.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:intl/intl.dart';
import 'package:cmsc128_lab/utils/firestore_utils.dart';

class OtherRoutines extends StatefulWidget {
  const OtherRoutines({super.key});

  @override
  State<OtherRoutines> createState() => _OtherRoutines();
}

class _OtherRoutines extends State<OtherRoutines> {
  final DBroutineService _databaseService = DBroutineService();

 
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
        child: StreamBuilder(
            stream: _databaseService.getOthers(),
            builder: (context, snapshot) {
              List routines = snapshot.data?.docs ?? [];
              if (snapshot.hasError) {
                return const Text("Connection error");
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Column(children: [
                  CircularProgressIndicator(),
                  Text("Loading")
                  ],
                );
              }

              return ListView.builder(
                  padding: EdgeInsets.all(0.0),
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: routines.length,
                  itemBuilder: (context, index) {
                    Routine routine = routines[index].data();
                    //ID
                    String routineID = routines[index].id;
                    return Container(
                      
                      alignment: FractionalOffset.center,
                      decoration: myBoxDecoration(),
                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                      child: ListTile(
                        leading: Icon(IconlyBold.bag_2,
                            size: 30,
                            color: Color(routine.color)),
                        title: Text(routine.name,
                            style: GoogleFonts.lexendDeca(
                                textStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ))),
                        subtitle: Text('Activites: ${routine.numActivities.toString()}',
                            style: TextStyle(
                            fontSize: 11,
                            fontFamily: GoogleFonts.lexendDeca().fontFamily,
                            color: Colors.black.withOpacity(0.5))),
                      ),
                    );
                  });
            }),
    );
  }
}

BoxDecoration myBoxDecoration() {
  return BoxDecoration(
    border: Border.all(color: const Color.fromARGB(255, 255, 255, 255)),
    color: Color.fromARGB(255, 254, 254, 254),
    borderRadius: BorderRadius.circular(20.0),
  );
}
