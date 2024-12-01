import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../utils/styles.dart';
import 'add_task_form.dart';

class AddTaskDialog extends StatelessWidget {
  const AddTaskDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog.fullscreen(
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            titleTextStyle: TextStyle(
                color: StyleColor.primaryText,
                fontSize: 20,
                fontWeight: FontWeight.w600,
                fontFamily: GoogleFonts.lexendDeca().fontFamily),
            title: const Text(
              "Add a Task",
            ),
            leading: IconButton(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              icon: const Icon(IconlyBold.arrow_left),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          body: const Column(
            children: [AddTaskForm()],
          )),
    );
  }
}
