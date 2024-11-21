import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TitleWithIcon extends StatelessWidget {
  const TitleWithIcon({
    super.key,
    required this.text,
    required this.icon,
    required this.iconBgColor,
  });

  final String text;
  final dynamic icon;
  final Color iconBgColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          text,
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              fontFamily: GoogleFonts.lexendDeca().fontFamily),
        ),
        const SizedBox(width: 5),
        Container(
          padding: const EdgeInsets.all(8),
          constraints: const BoxConstraints(
            maxWidth: 50,
          ),
          decoration: BoxDecoration(
            color: iconBgColor,
            shape: BoxShape.circle,
          ),
          child: icon,
        )
      ],
    );
  }
}
