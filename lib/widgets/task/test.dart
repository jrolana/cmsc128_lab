import 'package:flutter/material.dart';
import 'package:cmsc128_lab/utils/firestore_utils.dart';

class TestFetchTasks extends StatefulWidget {
  const TestFetchTasks({super.key});

  @override
  State<TestFetchTasks> createState() => _TestFetchTasksState();
}

class _TestFetchTasksState extends State<TestFetchTasks> {
  List<Map<String, dynamic>> tasks = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchTasks(); // Fetch tasks on widget initialization
  }

  Future<void> fetchTasks({List<String>? filterCategories}) async {
    setState(() {
      isLoading = true;
    });

    List<Map<String, dynamic>> fetchedTasks =
        await FirestoreUtils.getTasks(filterCategories: filterCategories);

    setState(() {
      tasks = fetchedTasks;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Test Fetch Tasks")),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : tasks.isEmpty
              ? const Center(child: Text("No tasks found"))
              : ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    final task = tasks[index];
                    return ListTile(
                      title: Text(task['name'] ?? 'Unnamed Task'),
                      subtitle: Text(task['category'] ?? 'No category'),
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Example of filtering tasks by categories
          await fetchTasks(filterCategories: []);
        },
        child: const Icon(Icons.filter_list),
      ),
    );
  }
}
