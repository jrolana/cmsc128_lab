import 'package:cmsc128_lab/utils/styles.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

class FetchingData extends StatelessWidget {
  const FetchingData({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
      width: 400,
      height: 150,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(),
          Text(
            "Fetching data...",
            style: TextStyle(
                color: StyleColor.primary,
                fontWeight: FontWeight.w600,
                fontFamily: GoogleFonts.lexendDeca().fontFamily),
          ),
        ],
      ),
    );
  }
}
