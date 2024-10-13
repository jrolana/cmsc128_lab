import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StyleText {
  StyleText._();

  static final TextStyle labelStyle = TextStyle(
      color: Colors.white,
      fontSize: 14,
      fontWeight: FontWeight.w600,
      fontFamily: GoogleFonts.lexendDeca().fontFamily);

  static final TextStyle unselectedLabelStyle = TextStyle(
      color: StyleColor.primary,
      fontSize: 14,
      fontWeight: FontWeight.w500,
      fontFamily: GoogleFonts.lexendDeca().fontFamily);
}

class StyleColor {
  StyleColor._();

  static const Color primary = Color(0xFF5F33E0);
  static const Color secondary = Color(0xFF8A6DF2);
  static const Color tertiary = Color(0xFFAC99F2);
  static const Color alternate = Color(0xFFede8ff);

  static const Color accentPink = Color(0xFFF68BC2);
  static const Color accentBlue = Color(0xFF7AC1FF);
  static const Color accentOrange = Color(0xFFFFEDE4);
  static const Color accentYellow = Color(0xFFFDFCE7);

  static const Color primaryText = Color(0xFF24252C);
}
