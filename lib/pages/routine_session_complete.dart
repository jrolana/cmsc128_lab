import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cmsc128_lab/models/activity.dart';
import 'package:cmsc128_lab/service/database_service.dart';
import 'package:cmsc128_lab/utils/firestore_utils.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';

import '../models/routine.dart';
import '../utils/styles.dart';
import 'navbar.dart';

class RoutineSessionComplete extends StatefulWidget {
  final String routineID;
  const RoutineSessionComplete(this.routineID,{super.key});

  @override
  State<RoutineSessionComplete> createState() => _StateRoutineSessionComplete();
}

class _StateRoutineSessionComplete extends State<RoutineSessionComplete> {
  FirestoreUtils routineDB = FirestoreUtils();
  late Routine routine;
  List activities = [];
  @override
  void initState() {
    // TODO: implement initState
    getRoutine();

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: (){

        for(var x in activities){
          Activity act = x.data() as Activity;
          if (act.type == 'activity'){
          Map<String,dynamic> data = {
            "date":Timestamp.fromDate(DateTime.now()).toString(),
            "actId": act.name
          };
          print(act);
          routineDB.getRoutine(widget.routineID).collection('completedActivities').add(data);
          }

        for(var x in activities){
          Activity act = x.data() as Activity;
          if (act.type == 'activity'){
          Map<String,dynamic> data = {
            "date":DateTime.now().toString(),
            "actId": act.name
          };
          print(act);
          routineDB.getRoutine(widget.routineID).collection('completedActivities').add(data);
          }


        }
        Navigator.push(context, MaterialPageRoute(builder: (context)=> BottomNavBar()));
        DatabaseService.updateStreak();
      }},child: Icon(Icons.done),),
      body: Column(
        children: [
          congratulations()
        ],
      ),
    );
  }
  ConfettiController _controller = ConfettiController(duration: const Duration(seconds: 10));
  Widget congratulations(){
    return ConfettiWidget(
      confettiController: _controller,
      blastDirectionality: BlastDirectionality.explosive,
      shouldLoop: false,
      colors: const [
        StyleColor.secondary,
        StyleColor.tertiary,
        StyleColor.accentYellow,
        StyleColor.accentPink,
      ],
      child: Container(
        margin: const EdgeInsets.all(20),
        padding: const EdgeInsets.fromLTRB(40, 35, 40, 35),
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Congratulations",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                        color: StyleColor.primary,
                        fontFamily: GoogleFonts.lexendDeca().fontFamily,
                      ),
                    ),
                    Text(
                      "Nice Work",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: StyleColor.primary,
                        fontFamily: GoogleFonts.lexendDeca().fontFamily,
                      ),
                    ),
                  ],
                ),
                const Icon(
                  IconlyBold.star,
                  size: 10,
                  color: StyleColor.primary,
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              "You completed your routine.",
              style: TextStyle(
                fontFamily: GoogleFonts.lexendDeca().fontFamily,
              ),
            ),
          ],
        ),
      ),
    );
  }
  void getRoutine() async {

    var snap = await routineDB.getRoutine(widget.routineID).get();
    routine  = snap.data() as Routine;
    var snap2 = await routineDB.getActivities(widget.routineID).get();
    activities = snap2.docs;
  }

}
