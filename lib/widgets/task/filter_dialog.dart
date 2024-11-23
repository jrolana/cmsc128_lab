import 'package:cmsc128_lab/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:cmsc128_lab/data/task_data.dart';
import 'package:google_fonts/google_fonts.dart';

class FilterDialog extends StatefulWidget {
  final List<String> selectedCategories;
  final ValueChanged<List<String>> onApply;

  const FilterDialog({
    super.key,
    required this.selectedCategories,
    required this.onApply,
  });

  @override
  State<FilterDialog> createState() => _FilterDialogState();
}

class _FilterDialogState extends State<FilterDialog> {
  late List<String> _tempSelectedCategories;

  @override
  void initState() {
    super.initState();
    _tempSelectedCategories = List.from(widget.selectedCategories);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Filter Tasks",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: StyleColor.primary,
            fontSize: 16,
            fontFamily: GoogleFonts.lexendDeca().fontFamily,
          )),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: categories.map((category) {
          return CheckboxListTile(
            value: _tempSelectedCategories.contains(category),
            title: Text(category,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: StyleColor.primaryText,
                  fontSize: 14,
                  fontFamily: GoogleFonts.lexendDeca().fontFamily,
                )),
            onChanged: (bool? value) {
              setState(() {
                if (value == true) {
                  _tempSelectedCategories.add(category);
                } else {
                  _tempSelectedCategories.remove(category);
                }
              });
            },
          );
        }).toList(),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Cancel"),
        ),
        TextButton(
          onPressed: () {
            widget.onApply(_tempSelectedCategories);

            Navigator.pop(context);
          },
          child: const Text("Apply"),
        ),
      ],
    );
  }
}
