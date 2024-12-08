import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:iconly/iconly.dart';
import 'package:cmsc128_lab/data/task_data.dart';

class TaskBlock extends StatefulWidget {
  final String type = 'taskBlock';
  const TaskBlock({super.key});

  @override
  State<TaskBlock> createState() => _TaskBlockState();
}

class _TaskBlockState extends State<TaskBlock> {
  bool isLoading = false;
  Duration duration = Duration(minutes: 1);
  String? selectedCategory;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2), // Shadow color
            spreadRadius: 2, // How much the shadow spreads
            blurRadius: 5, // How blurry the shadow is
            offset: Offset(0, 4), // The shadow's position (x, y)
          ),
        ],
      ),
      child: SizedBox(
          height: 300,
          child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Column(
                children: [
                  Text(
                    "Task Block:",
                    style: TextStyle(
                        fontSize: 13,
                        fontFamily: GoogleFonts.lexendDeca().fontFamily,
                        color: Colors.black),
                  ),
                  Text(
                    "Select a category for your task",
                    style: TextStyle(
                        fontSize: 11,
                        fontFamily: GoogleFonts.lexendDeca().fontFamily,
                        color: Colors.black.withOpacity(0.5)),
                  ),
                  const SizedBox(height: 5),
                  TextButton(
                      onPressed: () => _showDialog(
                          context,
                          CupertinoTimerPicker(
                            mode: CupertinoTimerPickerMode.hms,
                            initialTimerDuration: duration,
                            // This is called when the user changes the timer's
                            // duration.
                            onTimerDurationChanged: (Duration newDuration) {
                              setState(() => duration = newDuration);
                            },
                          )),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(IconlyLight.time_circle),
                          const SizedBox(width: 5),
                          Text(_printDuration(duration)),
                        ],
                      )),
                  const SizedBox(height: 5),
                  isLoading
                      ? Center(child: CircularProgressIndicator())
                      : Expanded(
                          child: ListView(
                            children: categories.map((category) {
                              return Row(
                                children: [
                                  Checkbox(
                                    value: selectedCategory == category,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        selectedCategory =
                                            value == true ? category : null;
                                      });
                                    },
                                  ),
                                  Text(
                                    category,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              );
                            }).toList(),
                          ),
                        ),
                ],
              ))),
    );
  }
}

String _printDuration(Duration duration) {
  String twoDigitMinutes = duration.inMinutes.remainder(60).abs().toString();
  String twoDigitSeconds = duration.inSeconds.remainder(60).abs().toString();
  if (duration.inHours == 0) {
    return "$twoDigitMinutes min $twoDigitSeconds sec";
  } else {
    return "${duration.inHours} hr $twoDigitMinutes min";
  }
}

void _showDialog(BuildContext context, Widget child) {
  showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => Container(
            height: 216,
            padding: const EdgeInsets.only(top: 6.0),
            margin: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            color: CupertinoColors.systemBackground.resolveFrom(context),
            child: SafeArea(top: false, child: child),
          ));
}
