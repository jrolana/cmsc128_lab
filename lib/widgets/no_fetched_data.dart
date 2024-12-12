import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

class NoFetchedData extends StatelessWidget {
  const NoFetchedData({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
      width: 400,
      height: 150,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Center(
        child: Text(
            "No progress available.\nComplete routines to track your progress!🌱",
            style: TextStyle(
                fontSize: 12, fontFamily: GoogleFonts.lexendDeca().fontFamily)),
      ),
    );
  }
}
