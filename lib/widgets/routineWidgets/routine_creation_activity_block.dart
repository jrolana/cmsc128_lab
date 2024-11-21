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
  int minDuration = 1;
  int hourDuration = 0;
  Icon actIcon = Icon(Icons.square_rounded);
  TextEditingController actController = TextEditingController();
  String defActVal = 'Enter an activity name';
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
            Row(
              children: [
                Text('$hourDuration hr'),
                Text('$minDuration min')
              ],
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
}

