import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// import 'package:cmsc128_lab/utils/styles.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';

class ActivityBlock extends StatefulWidget {
  _DefaultActivityBlock _state = _DefaultActivityBlock();

  String getName(){
    return _state.actName;
  }
  String getIcon(){
    return _state.actIcon.toString();
  }
  int getDuration(){
    return _state.duration.inSeconds;
  }
  ActivityBlock({super.key});

  @override
  State<ActivityBlock> createState(){
    _state = _DefaultActivityBlock();
    return _state;
  }
}

class _DefaultActivityBlock extends State<ActivityBlock> {
  bool showTextField = false;
  String actName = 'Enter an activity name';
  Icon actIcon = Icon(Icons.square_rounded);
  TextEditingController actController = TextEditingController();
  String defActVal = 'Enter an activity name';
  Duration duration = Duration(minutes: 1);

  List getData() {
    return [actName, actIcon, duration];
  }

  String getName() {
    return actName;
  }

  String getIcon() {
    return actIcon.toString();
  }

  int getDuration() {
    return duration.inSeconds;
  }

  @override
  void dispose() {
    actController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {},
        child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Row(
              children: [
                IconButton(
                    onPressed: () {
                      _pickIcon();
                    },
                    icon: actIcon),
                Expanded(
                  child: showTextField
                      ? activityInputField()
                      : activityInputButton(),
                ),
                TextButton(
                  onPressed: () => _showDialog(CupertinoTimerPicker(
                    mode: CupertinoTimerPickerMode.hms,
                    initialTimerDuration: duration,
                    // This is called when the user changes the timer's
                    // duration.
                    onTimerDurationChanged: (Duration newDuration) {
                      setState(() => duration = newDuration);
                    },
                  )),
                  child: Text(_printDuration(duration)),
                )
              ],
            )));
  }

  get name => actName;

  get icon => actIcon;

  get dur => duration;

  Widget activityInputField() {
    return TextField(
      controller: actController,
      autofocus: true,
      onTapOutside: (event) {
        setState(() {
          actName = actController.text;
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
    );
  }

  Widget activityInputButton() {
    return TextButton(
        style: ButtonStyle(alignment: Alignment.centerLeft),
        onPressed: () {
          setState(() {
            actController.text = actName == defActVal ? '' : actName;
            showTextField = true;
          });
        },
        child: Text(
          actName,
          textAlign: TextAlign.left,
        ));
  }

  _pickIcon() async {
    IconPickerIcon? iconPicked = await showIconPicker(context);
    actIcon = Icon(iconPicked?.data);
    setState(() {});
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
