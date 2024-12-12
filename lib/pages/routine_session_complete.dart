import 'package:cmsc128_lab/service/database_service.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';

import '../utils/styles.dart';

class RoutineSessionComplete extends StatefulWidget {
  final String routineID;
  const RoutineSessionComplete(this.routineID,{super.key});

  @override
  State<RoutineSessionComplete> createState() => _StateRoutineSessionComplete();
}

class _StateRoutineSessionComplete extends State<RoutineSessionComplete> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: (){

        DatabaseService.updateStreak();
      },child: Icon(Icons.done),),
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
}
