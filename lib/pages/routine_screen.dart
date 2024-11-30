import 'package:cmsc128_lab/widgets/routineWidgets/routine_home_routine_block.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RoutineScreen extends StatefulWidget {
  const RoutineScreen({super.key});

  @override
  State<RoutineScreen> createState() => RoutineScreenState();
}

class RoutineScreenState extends State<RoutineScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: SingleChildScrollView(
          child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              
              //Completed Today Section
              Container(
                child: Column(
                  
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Completed Today", style: GoogleFonts.lexend(textStyle: TextStyle(fontWeight: FontWeight.bold,fontSize:18,))),
                      ),
                    RoutineBlock(),
                  ],
                ),
              ),
              
              //Upcoming Today Section
              Container(
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Upcoming Today",style: GoogleFonts.lexend(textStyle: TextStyle(fontWeight: FontWeight.bold,fontSize:18,))),
                      ),
                    RoutineBlock(),
                    RoutineBlock(),
        
                  ],
                ),
              ),
              //Other Routines
              Container(
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Other Routines",style: GoogleFonts.lexend(textStyle: TextStyle(fontWeight: FontWeight.bold,fontSize:18,))),
                      ),
                    RoutineBlock(),
                    RoutineBlock(),
                    RoutineBlock(),
                    RoutineBlock(),
        
                  ],
                ),
              ),
            ],
          ),
        ),
        ),
    );
  }
}
