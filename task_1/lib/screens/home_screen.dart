import 'package:flutter/material.dart';
import 'package:task_1/screens/tasks_details_screen.dart';
import '../services/api_service.dart';
import '../widgets/task_card.dart';
import 'add_task_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<List<dynamic>>? tasks;
  String selectedFilter = "All"; 

  @override
  void initState() {
    super.initState();
    fetchTasks();
  }

  void fetchTasks() {
    setState(() {
      tasks = ApiService.fetchTasks(); 
    });
  }

  void addTask(Map<String, dynamic> newTask) {
    setState(() {
      tasks = tasks!.then((currentTasks) => [...currentTasks, newTask]);
    });
  }

  void applyFilter(String filter) {
    setState(() {
      selectedFilter = filter;
      tasks = ApiService.fetchTasks().then((allTasks) {
        if (filter == "All") {
          return allTasks;
        } else {
          return allTasks.where((task) => task['tags'].contains(filter)).toList();
        }
      });
    });
  }

  void showFilterOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Filter Tasks",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              ListTile(
                title: const Text("All"),
                onTap: () {
                  applyFilter("All");
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text("UI Design"),
                onTap: () {
                  applyFilter("UI Design");
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text("Project"),
                onTap: () {
                  applyFilter("Project");
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text("Bug Fix"),
                onTap: () {
                  applyFilter("Bug Fix");
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Task Manager",
          style: TextStyle(
            color: Colors.black,
            fontSize: screenWidth * 0.05,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list, color: Colors.black),
            onPressed: () {
              showFilterOptions(context);
            },
          ),
        ],
      ),
      body: FutureBuilder<List<dynamic>>(
        future: tasks,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text("Failed to fetch tasks"));
          } else {
            return LayoutBuilder(
              builder: (context, constraints) {
                
                final isWideScreen = constraints.maxWidth > 600; 

                return Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: isWideScreen ? 32.0 : 16.0, 
                  ),
                  child: ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final task = snapshot.data![index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: TaskCard(
                          title: task['title'],
                          tags: task['tags'] ?? ["UI Design", "Project"], 
                          comments: task['comments'] ?? 0,
                          attachments: task['attachments'] ?? 0,
                          teamIcons: [
                            const AssetImage("assets/avatar1.jpg"),
                            const AssetImage("assets/avatar2.png"),
                            const AssetImage("assets/avatar1.jpg"),
                          ],
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => TaskDetailsScreen(task: task),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add, size: 32),
        onPressed: () async {
          final newTask = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddTaskScreen(onAddTask: addTask),
            ),
          );

          if (newTask != null) {
            addTask(newTask);
          }
        },
      ),
    );
  }
}
