import 'package:flutter/material.dart';
// import 'package:cmsc128_lab/utils/styles.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
class ActivityBlock extends StatefulWidget{
  const ActivityBlock({super.key});

  @override
  State<ActivityBlock> createState() => _DefaultActivityBlock();

}

class _DefaultActivityBlock extends State<ActivityBlock>{
  bool showTextField = false;
  String actName = 'Default Name';
  Icon actIcon = Icon(Icons.square_rounded);
  TextEditingController actController = TextEditingController();
  String defActVal = 'Enter an activity name';
  Duration duration=Duration(minutes: 1);
  @override
  void dispose() {
    actController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context){
    return ElevatedButton(
        onPressed: (){},
        child: Padding(
            padding: EdgeInsets.symmetric(vertical:10,horizontal: 20),
            child: Row(
          children: [
            IconButton(
                onPressed: (){
                   _pickIcon();
                },
                icon: actIcon),
            Expanded(
              child: showTextField ? activityInputField() : activityInputButton(),
            ),
            TextButton(
              onPressed: () {  },
              child: Text(_printDuration(duration)),

            )
          ],
        ))
    );
  }
  Widget activityInputField(){
    return TextField(
      controller: actController,
      autofocus: true,
      onSubmitted: (String value){
          setState(() {
            showTextField = false;
            actName = value.isEmpty ? defActVal:value;
          });
        },
      textAlign: TextAlign.left,
    );
  }

  Widget activityInputButton(){
    return TextButton(
        onPressed: (){
          setState(() {
            actController.text = actName == defActVal? '':actName;
            showTextField = true;
          });
        },
        child: Text(actName, textAlign: TextAlign.left,));
  }
  _pickIcon() async{
      IconPickerIcon? iconPicked = await showIconPicker(context);
      actIcon = Icon(iconPicked?.data);
      setState(() {});
  }
  String _printDuration(Duration duration) {

    String twoDigitMinutes = duration.inMinutes.remainder(60).abs().toString();
    String twoDigitSeconds = duration.inSeconds.remainder(60).abs().toString();
    if(duration.inHours ==0 ){
      return "$twoDigitMinutes min $twoDigitSeconds sec";
    } else{
      return "${duration.inHours} hr $twoDigitMinutes min";
    }
  }
}

