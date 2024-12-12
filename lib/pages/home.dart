import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:cmsc128_lab/pages/dynamic_routine_screen.dart';
import 'package:flutter/material.dart';
import '../utils/styles.dart';
import 'package:google_fonts/google_fonts.dart';
import 'task_screen.dart';

class HomePage extends StatefulWidget {
  final ValueChanged<String> onTabChanged;
  const HomePage({super.key, this.onTabChanged = _defaultTabChanged});

  static void _defaultTabChanged(String tab) {}

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late TabController _tcontroller;
  final ValueNotifier<String> currentTab = ValueNotifier<String>("Routines");

  @override
  void initState() {
    _tcontroller = TabController(length: 2, vsync: this);
    _tcontroller.addListener(() {
      String selectedTab = _tcontroller.index == 0 ? "Routines" : "Tasks";
      widget.onTabChanged(selectedTab);
      currentTab.value = selectedTab;
    });
    super.initState();
  }

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
            title: ValueListenableBuilder<String>(
              valueListenable: currentTab,
              builder: (_, value, __) => Text("Your $value"),
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
                    children: [DynamicHomeRoutine(), TaskScreen()]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
