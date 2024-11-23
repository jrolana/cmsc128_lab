import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import '../utils/styles.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cmsc128_lab/widgets/searchbox.dart';
import 'package:cmsc128_lab/widgets/task/task_list.dart';
import 'package:cmsc128_lab/widgets/task/filter_dialog.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => TaskScreenState();
}

class TaskScreenState extends State<TaskScreen>
    with AutomaticKeepAliveClientMixin {
  List<String> _selectedCategories = [];

  @override
  bool get wantKeepAlive => true;

  void showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return FilterDialog(
            selectedCategories: _selectedCategories,
            onApply: (List<String> categories) {
              setState(() {
                _selectedCategories = categories;
              });
            });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            const SearchBox(),
            Container(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Tasks',
                      style: TextStyle(
                          fontFamily: GoogleFonts.lexendDeca().fontFamily,
                          fontSize: 16,
                          fontWeight: FontWeight.bold)),
                  IconButton(
                      icon: const Icon(IconlyBold.filter_2),
                      iconSize: 25,
                      color: StyleColor.primary,
                      onPressed: () {
                        showFilterDialog();
                      }),
                ],
              ),
            ),
            TaskList(filterCategories: _selectedCategories),
          ],
        ),
      ),
    );
  }
}
