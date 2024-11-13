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

  List<Widget> widgetOptions = <Widget> [
    HomePage(),
    Statistics(),
    //Text('Account'),
    HomePage()//For now cuz Empty pa ung account page
   ];

  //Function to select on List
   void _onItemTap(int index){
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
      floatingActionButton: FloatingActionButton(child: Icon(Icons.add),
      tooltip: 'Add Task/Routine', // Gonna have to fix this para specific 
      foregroundColor: Colors.white,
      backgroundColor: Color.fromRGBO(95, 51, 225, 1),
      shape: RoundedRectangleBorder(side: BorderSide(width: 5,color: Colors.white,),borderRadius: BorderRadius.circular(100)),
      elevation: 0.0,
      onPressed: () {
        //Should redirect to Add Routine/Task
        print("test");
      },
      ),
      bottomNavigationBar: Container( 
        margin: EdgeInsets.only(top: 7.50, left: 0.0, right: 0.0),
        child: BottomNavigationBar(
          
          backgroundColor: const Color.fromRGBO(238, 233, 255, 1),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.task_alt_outlined),
              activeIcon: Icon(Icons.task_alt_sharp),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.poll_outlined),
              activeIcon: Icon(Icons.poll_sharp),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline_rounded),
              activeIcon: Icon(Icons.person_rounded),
              label: "",
            ),
          ],
          currentIndex: _currentIndex,
          onTap: _onItemTap, //Passing on Tap
        )
      ),
    );
  }
}
