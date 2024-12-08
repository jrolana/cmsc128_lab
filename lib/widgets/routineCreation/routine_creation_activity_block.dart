import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// import 'package:cmsc128_lab/utils/styles.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:google_fonts/google_fonts.dart';

class ActivityBlock extends StatefulWidget {
  final String type = 'activity';
  _DefaultActivityBlock _state = _DefaultActivityBlock();

  String getName() {
    return _state.actName;
  }

  int? getIcon() {
    return _state.actIcon.icon?.codePoint;
  }

  int getDuration() {
    return _state.duration.inSeconds;
  }

  ActivityBlock({super.key});

  @override
  State<ActivityBlock> createState() {
    _state = _DefaultActivityBlock();
    return _state;
  }
}

class _DefaultActivityBlock extends State<ActivityBlock> {
  bool showTextField = false;
  String actName = 'Enter an activity name';
  Icon actIcon = Icon(Icons.square_rounded, size: 12);
  TextEditingController actController = TextEditingController();
  String defActVal = 'Enter an activity name';
  Duration duration = Duration(minutes: 1);

  @override
  void dispose() {
    actController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          backgroundColor: Colors.white,
          shadowColor: Colors.black,
          elevation: 2.0
        ),
        onPressed: () {},
        child: Row(
          children: [
            IconButton(
                style: IconButton.styleFrom(
                  padding: EdgeInsets.zero
                ),
                onPressed: () {
                  _pickIcon();
                },
                icon: actIcon),
            Expanded(
              child:
                  showTextField ? activityInputField() : activityInputButton(),
            ),
            TextButton(
              style:TextButton.styleFrom(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.zero,
                ),
              onPressed: () => _showDialog(CupertinoTimerPicker(
                mode: CupertinoTimerPickerMode.hms,
                initialTimerDuration: duration,
                // This is called when the user changes the timer's
                // duration.
                onTimerDurationChanged: (Duration newDuration) {
                  setState(() => duration = newDuration);
                },
              )),
              child: Text(_printDuration(duration),
                  style: TextStyle(
                      fontSize: 8,
                      fontFamily: GoogleFonts.lexendDeca().fontFamily)),
            )
          ],
        )
    );
  }

  Widget activityInputField() {
    return TextField(
        maxLength: 20,
        controller: actController,
        autofocus: true,
        onTapOutside: (event) {
          setState(() {
            actName = actController.text.isEmpty? defActVal:actController.text;
            showTextField = false;
          });
        },
        onSubmitted: (String value) {
          setState(() {
            showTextField = false;
            actName = value.isEmpty ? defActVal : value;
          });
        },
        textAlign: TextAlign.left,
        style: TextStyle(
            fontSize: 12, fontFamily: GoogleFonts.lexendDeca().fontFamily));
  }

  Widget activityInputButton() {
    return TextButton(
        style: TextButton.styleFrom(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.zero,
        ),
        onPressed: () {
          setState(() {
            actController.text = actName == defActVal ? '' : actName;
            showTextField = true;
          });
        },
        child: Text(
          actName,
          textAlign: TextAlign.left,
          style: TextStyle(
              fontSize: 12, fontFamily: GoogleFonts.lexendDeca().fontFamily),
        ));
  }

  _pickIcon() async {
    IconPickerIcon? iconPicked = await showIconPicker(context);
    IconData iconData = iconPicked!.name.isEmpty? Icons.access_time_outlined : iconPicked.data;

    setState(() {
      actIcon =
          Icon(iconData, size: MediaQuery.of(context).size.width * 0.06);
    });
  }

  String _printDuration(Duration duration) {
    String twoDigitMinutes = duration.inMinutes.remainder(60).abs().toString();
    String twoDigitSeconds = duration.inSeconds.remainder(60).abs().toString();
    if (duration.inHours == 0) {
      return "${twoDigitMinutes} min ${twoDigitSeconds} sec";
    } else {
      return "${duration.inHours} hr ${twoDigitMinutes} min";
    }
  }

  void _showDialog(Widget child) {
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
}
