import 'package:cmsc128_lab/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:cmsc128_lab/data/task_data.dart';

class AddTaskForm extends StatefulWidget {
  const AddTaskForm({super.key});

  @override
  State<AddTaskForm> createState() => _AddTaskFormState();
}

class _AddTaskFormState extends State<AddTaskForm> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _taskNameController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  String _selectedCategory = "Personal";

  Future<void> _selectDate() async {
    DateTime? _selected = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (_selected != null) {
      setState(() {
        _dateController.text = _selected.toString().split(" ")[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          children: [
            // Task Name
            TextFormField(
              controller: _taskNameController,
              decoration: const InputDecoration(
                label: Text('Task Name'),
                prefixIcon:
                    Icon(IconlyLight.edit_square, color: StyleColor.primary),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter task name';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            // Input Date
            TextFormField(
              controller: _dateController,
              decoration: const InputDecoration(
                  label: Text('Enter Date'),
                  // filled: true,
                  prefixIcon:
                      Icon(IconlyLight.calendar, color: StyleColor.primary),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 1.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: StyleColor.primary, width: 1.0),
                  )),
              readOnly: true,
              onTap: () {
                _selectDate();
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please input date';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            // Category
            DropdownButtonFormField(
                value: _selectedCategory,
                decoration: const InputDecoration(
                  label: Text('Category'),
                ),
                items: categories.map((c) {
                  return DropdownMenuItem(
                    value: c,
                    child: Text(c),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedCategory = value!;
                  });
                }),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      String taskName = _taskNameController.text;
                      taskName =
                          taskName[0].toUpperCase() + taskName.substring(1);
                      // Change to store values in database
                      print(taskName);
                      print(_dateController.text);
                      // Convert String to DateTime object
                      print(DateTime.parse(_dateController.text));
                      print(_selectedCategory);

                      // Notify if added successfully
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Task Added Successfully')),
                      );
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('Add')),
            ),
          ],
        ),
      ),
    );
  }
}
