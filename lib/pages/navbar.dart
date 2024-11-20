import 'package:cmsc128_lab/pages/routine_creation.dart';
import 'package:cmsc128_lab/pages/routine_screen.dart';
import 'package:flutter/material.dart';
import 'home.dart';
import 'statistics.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _currentIndex = 0;
  Widget screenNav = RoutineCreation();
  List<Widget> widgetOptions = <Widget>[
    HomePage(),
    Statistics(),
    //Text('Account'),
    HomePage() //For now cuz Empty pa ung account page
  ];

  //Function to select on List
  void _onItemTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: widgetOptions.elementAt(_currentIndex),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add, size: 30,),
        tooltip: 'Add Routine', // Gonna have to fix this para specific
        foregroundColor: Colors.white,
        backgroundColor: Color.fromRGBO(95, 51, 225, 1),
        shape: RoundedRectangleBorder(side: BorderSide(width: 5,color: Colors.white, style: BorderStyle.none),borderRadius: BorderRadius.circular(100)),
        elevation: 5.0,
        onPressed: () {
          //Should redirect to Add Routine/Task
          print("test");
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => screenNav )
          );
        },
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
              items: [
                BottomNavigationBarItem(
                  backgroundColor: Colors.transparent,
                  icon: Icon(Icons.task_alt_outlined),
                  label: "",
                ),
                BottomNavigationBarItem(
                  backgroundColor: Colors.transparent,
                  icon:Icon(Icons.poll),
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
            )
          )
        ),
    );
  }
}
