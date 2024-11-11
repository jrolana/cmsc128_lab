import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:cmsc128_lab/pages/statistics_daily.dart';
import 'package:flutter/material.dart';
import '../utils/styles.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';

class Statistics extends StatefulWidget {
  Statistics({super.key});

  @override
  State<Statistics> createState() => _StatisticsState();
}

class _StatisticsState extends State<Statistics> with TickerProviderStateMixin {
  static const List<Tab> tabs = [
    Tab(
      text: 'Day',
    ),
    Tab(
      text: 'Week',
    ),
    Tab(
      text: 'Month',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            titleTextStyle: TextStyle(
                color: StyleColor.primaryText,
                fontSize: 20,
                fontWeight: FontWeight.w600,
                fontFamily: GoogleFonts.lexendDeca().fontFamily),
            title: const Text(
              "Routine Statistics",
            ),
            leading: IconButton(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              icon: const Icon(IconlyBold.arrow_left),
              onPressed: () {
                print("Pressed back");
              },
            ),
          ),
          body: Column(
            children: <Widget>[
              ButtonsTabBar(
                radius: 14,
                width: 125,
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
                child: TabBarView(children: [
                  new StatisticsDaily(),
                  Icon(Icons.directions_boat),
                  Icon(Icons.directions_boat),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
