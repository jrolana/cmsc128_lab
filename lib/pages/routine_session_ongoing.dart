import 'package:cmsc128_lab/pages/routine_session_timer.dart';
import 'package:flutter/material.dart';
import '../models/activity.dart';
import '../models/routine.dart';
import '../utils/firestore_utils.dart';

class RoutineSessionOngoing extends StatefulWidget {
  final String routineID;
  final int actNum;

  const RoutineSessionOngoing(this.routineID, this.actNum, {super.key});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _StateRoutineSessionOngoing();
  }
}

class _StateRoutineSessionOngoing extends State<RoutineSessionOngoing> {
  FirestoreUtils db = FirestoreUtils();
  PageController _pageViewController = PageController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Back',
        ),
        title: const Text('Routine Session'),
      ),
      body: StreamBuilder(
          stream: db.getActivities(widget.routineID).snapshots(),
          builder: (context, snapshot) {
            List activities = snapshot.data?.docs ?? [];
            return PageView.builder(
              itemBuilder: (context, index) {
                Activity act = activities[index].data();
                return RoutineSessionTimer(
                    act.name, act.duration, act.icon, index, _navigatePage);
              },
              controller: _pageViewController,
              onPageChanged: _handlePageChange,
              physics: const NeverScrollableScrollPhysics(),
            );
          }),
    );
  }

  void _handlePageChange(int currentPageIndex) {
    print('page changed');
  }

  void _navigatePage(int index) {
    if (index == widget.actNum) {
      // TODO session complete
    } else {
      _pageViewController.animateToPage(
        index,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeOutExpo,
      );
    }
  }
}
