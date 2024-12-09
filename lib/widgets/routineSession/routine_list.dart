import 'package:flutter/material.dart';

import '../../models/activity.dart';
import '../../utils/firestore_utils.dart';

class RoutineSessionList extends StatefulWidget {
  final String routineID;

  const RoutineSessionList(this.routineID, {super.key});

  @override
  State<RoutineSessionList> createState() =>
      _RoutineSessionListState();

}

class _RoutineSessionListState extends State<RoutineSessionList> {
  late List activityIDs;
  FirestoreUtils dbService = FirestoreUtils();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _messagesListView();
  }

  Widget _messagesListView() {
    return SizedBox(
        height: MediaQuery
            .sizeOf(context)
            .height * 0.80,
        width: MediaQuery
            .sizeOf(context)
            .width,
        child: StreamBuilder(
            stream: dbService.getActivities(widget.routineID).snapshots(),
            builder: (context, snapshot) {
              List activities = snapshot.data?.docs ?? [];
              return ListView.separated(
                  itemBuilder: (context,index){
                    //print(activities[index]);
                    Activity activity = activities[index].data();
                    return ElevatedButton(
                        onPressed: (){},
                        child:ListTile(
                      leading: Icon(IconData(activity.icon,fontFamily: 'MaterialIcons')) ,
                      title: Text(activity.name),
                          trailing: Text(_printDuration(Duration(seconds: activity.duration))),
                    ));
                  },
                  separatorBuilder: (context, index) {
                     return const SizedBox(
                              height: 10,
                     );},
                  itemCount: activities.length);
            }
        )
    );
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
}