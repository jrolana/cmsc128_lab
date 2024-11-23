import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:cmsc128_lab/pages/routine_screen.dart';
import 'package:flutter/material.dart';
import '../utils/styles.dart';
import 'package:google_fonts/google_fonts.dart';
import 'task_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late TabController _tcontroller;

  @override
  void initState() {
    _tcontroller = TabController(length: 2, vsync: this);
    _tcontroller.addListener(_changeAppBarText);
    super.initState();
  }

  void _changeAppBarText() => setState(() {});

  static const List<Tab> tabs = [
    Tab(
      text: 'Routines',
    ),
    Tab(
      text: 'Tasks',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    String currentTitle;

    if (_tcontroller.index == 0) {
      currentTitle = 'Routines';
    } else {
      currentTitle = 'Tasks';
    }

    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            titleTextStyle: TextStyle(
                color: StyleColor.primaryText,
                fontSize: 20,
                fontWeight: FontWeight.w600,
                fontFamily: GoogleFonts.lexendDeca().fontFamily),
            title: Text(
              "Your $currentTitle",
            ),
          ),
          body: Column(
            children: <Widget>[
              ButtonsTabBar(
                controller: _tcontroller,
                radius: 14,
                width: 185,
                height: 60,
                buttonMargin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                contentCenter: true,
                backgroundColor: StyleColor.primary,
                unselectedBackgroundColor: StyleColor.alternate,
                labelStyle: StyleText.labelStyle,
                unselectedLabelStyle: StyleText.unselectedLabelStyle,
                tabs: tabs,
              ),
              // To be replaced with pages
              Expanded(
                child: TabBarView(
                    controller: _tcontroller,
                    children: [RoutineScreen(), TaskScreen()]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
