import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cmsc128_lab/model/routine.dart';
import 'package:cmsc128_lab/utils/firestore_utils.dart';
import 'package:cmsc128_lab/widgets/routineWidgets/complete_today_block.dart';
import 'package:cmsc128_lab/widgets/routineWidgets/upcoming_today_block.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cmsc128_lab/widgets/routineWidgets/other_routine_block.dart';
import 'package:cmsc128_lab/widgets/routineWidgets/all_routines_block.dart';

class DynamicHomeRoutine extends StatefulWidget {
  const DynamicHomeRoutine({super.key});

  @override
  State<DynamicHomeRoutine> createState() => _DynamicHomeRoutineState();
}

class _DynamicHomeRoutineState extends State<DynamicHomeRoutine> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            margin: const EdgeInsets.only(bottom: 70),
            child: Column(
              children: [
                Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text("All Routines",
                          style: GoogleFonts.lexend(
                              textStyle: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ))),
                    ),
                    const AllRoutines(),
                  ],
                ),
                //Completed Today
                Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Completed Today",
                          style: GoogleFonts.lexend(
                              textStyle: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ))),
                    ),
                    const CompleteTodayBlock(),
                  ],
                ),
                //Upcoming Today
                // Column(
                //   children: [
                //     Align(
                //       alignment: Alignment.centerLeft,
                //       child: Text("Upcoming Today",
                //           style: GoogleFonts.lexend(
                //               textStyle: const TextStyle(
                //             fontWeight: FontWeight.bold,
                //             fontSize: 18,
                //           ))),
                //     ),
                //     const UpcomingTodayBlock(),
                //   ],
                // ),
                //Other Routines
                Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Other Routines",
                          style: GoogleFonts.lexend(
                              textStyle: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ))),
                    ),
                    const AllRoutines(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     body: Center(
  //       child: isLoaded?ListView.builder(
  //         itemCount: items.length,
  //         itemBuilder: (context, index){
  //           return Padding(
  //             padding: const EdgeInsets.all(8.0),
  //             child: ListTile(
  //               shape: RoundedRectangleBorder(
  //                 side: BorderSide(width: 2),
  //               ),
  //               leading: const CircleAvatar(),
  //               title: Row(children: [
  //                 Text("Testing"),
  //                 SizedBox(width: 10)
  //               ],),
  //             ),
  //             );
  //           }
  //         ):Text("no data")
  //     ),
  //   );
  // }
}
