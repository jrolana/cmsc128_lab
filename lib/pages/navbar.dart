import 'package:cmsc128_lab/pages/routine_creation.dart';
import 'package:flutter/material.dart';
import 'home.dart';
import 'statistics.dart';
import 'profile_screen.dart';
import 'package:cmsc128_lab/widgets/task/add_task_dialog.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _currentIndex = 0;
  String _currentTab = "Routines";

  late List<Widget> widgetOptions;

  void updateCurrentTab(String tab) {
    setState(() {
      _currentTab = tab; // Update the current tab when HomePage notifies
    });
  }

  //Function to select on List
  void _onItemTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  // Used to show the dialog for adding tasks
  // when the user is in the task page
  void showAddTaskDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return const AddTaskDialog();
      },
    );
  }

  @override
  void initState() {
    super.initState();
    widgetOptions = <Widget>[
      HomePage(onTabChanged: (tab) {
        updateCurrentTab(tab);
      }),
      Statistics(),
      //Text('Account'),
      ProfileScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: widgetOptions.elementAt(_currentIndex),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add Task/Routine', // Gonna have to fix this para specific
        foregroundColor: Colors.white,
        backgroundColor: Color.fromRGBO(95, 51, 225, 1),
        shape: RoundedRectangleBorder(
            side: const BorderSide(
                width: 5, color: Colors.white, style: BorderStyle.none),
            borderRadius: BorderRadius.circular(100)),
        elevation: 5.0,
        onPressed: () {
          if (_currentTab == "Routines") {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const RoutineCreation()),
            );
          } else if (_currentTab == "Tasks") {
            showAddTaskDialog();
          }
        },
        child: Icon(
          Icons.add,
          size: 30,
        ),
      ),
      extendBody: true,
      bottomNavigationBar: BottomAppBar(
          color: Color.fromRGBO(238, 233, 255, 1),
          notchMargin: 7.5,
          shape: CircularNotchedRectangle(),
          padding: EdgeInsets.all(0),
          clipBehavior: Clip.hardEdge,
          child: Container(
              padding: EdgeInsets.all(0),
              margin: EdgeInsets.only(left: 20, right: 60, top: 0, bottom: 0),
              child: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                selectedFontSize: 0,
                unselectedFontSize: 0,
                unselectedItemColor: const Color.fromARGB(103, 80, 16, 139),
                selectedItemColor: Colors.indigo[700],
                backgroundColor: Colors.transparent,
                iconSize: 35,
                elevation: 0,
                items: const [
                  BottomNavigationBarItem(
                    backgroundColor: Colors.transparent,
                    icon: Icon(Icons.task_alt_outlined),
                    label: "",
                  ),
                  BottomNavigationBarItem(
                    backgroundColor: Colors.transparent,
                    icon: Icon(Icons.poll),
                    label: "",
                  ),
                  BottomNavigationBarItem(
                    backgroundColor: Colors.transparent,
                    icon: Icon(Icons.person_outline_rounded),
                    label: "",
                  ),
                ],
                currentIndex: _currentIndex,
                onTap: _onItemTap, //Passing on Tap
              ))),
    );
  }
}
