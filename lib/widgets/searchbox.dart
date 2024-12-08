import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import '../utils/styles.dart';

class SearchBox extends StatelessWidget {
  final Function(String) onSearch;

  const SearchBox({super.key, required this.onSearch});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(1, 2),
          ),
        ],
      ),
      child: TextField(
        onChanged: onSearch,
        decoration: InputDecoration(
          prefixIcon: const Icon(
            IconlyLight.search,
            color: StyleColor.primary,
          ),
          hintText: 'Search',
          hintStyle: GoogleFonts.lexendDeca(
            textStyle: const TextStyle(
              color: Colors.grey,
            ),
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 12),
        ),
      ),
    );
  }
}
