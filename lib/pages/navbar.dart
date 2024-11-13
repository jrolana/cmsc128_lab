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
        child: Icon(Icons.add),
      tooltip: 'Add Task/Routine', // Gonna have to fix this para specific 
      foregroundColor: Colors.white,
      backgroundColor: Color.fromRGBO(95, 51, 225, 1),
      shape: RoundedRectangleBorder(side: BorderSide(width: 5,color: Colors.white, style: BorderStyle.none),borderRadius: BorderRadius.circular(100)),
      elevation: 0.0,
      onPressed: () {
        //Should redirect to Add Routine/Task
        print("test");
      },
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.all(0.0),
        padding: EdgeInsets.all(0.0),
        child: BottomAppBar(
          color: const Color.fromRGBO(238, 233, 255, 1),
          notchMargin: 7.5,
          height: 99,
          shape: CircularNotchedRectangle(),
          clipBehavior: Clip.antiAlias,
          child: Container(
            margin: EdgeInsets.only(left: 40, right: 40, top: 0, bottom: 0),
            padding: EdgeInsets.all(0.0), 
              child: BottomNavigationBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              type: BottomNavigationBarType.fixed,
              items: [
                BottomNavigationBarItem(
                  icon: Container(
                    margin: EdgeInsets.only(top: 5, bottom: 0),
                    padding: EdgeInsets.only(top: 5),
                    child: Icon(Icons.task_alt_outlined, size: 30,)),
                  label: "",
                ),
                BottomNavigationBarItem(
                  icon: Container(
                    margin: EdgeInsets.only(top: 5, bottom: 0),
                    padding: EdgeInsets.only(top: 5),
                    child: Icon(Icons.poll, size: 30,)),
                  label: "",
                ),
                BottomNavigationBarItem(
                  icon: Container(
                    margin: EdgeInsets.only(top: 5, bottom: 0),
                    padding: EdgeInsets.only(top: 5),
                    child: Icon(Icons.person_outline_rounded, size: 30,)),
                  label: "",
                ),
                ],
              currentIndex: _currentIndex,
              onTap: _onItemTap, //Passing on Tap
            )
          )
        ),
      ),
    );
  }
}
