import 'package:flutter/material.dart';

class AddTaskScreen extends StatefulWidget {
  final Function(Map<String, dynamic>) onAddTask;

  const AddTaskScreen({Key? key, required this.onAddTask}) : super(key: key);

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final TextEditingController _titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;
    final isWideScreen = screenWidth > 600; 

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add Task",
          style: TextStyle(fontSize: screenWidth * 0.05), 
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(screenWidth * 0.04), 
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _titleController,
                style: TextStyle(fontSize: screenWidth * 0.04), 
                decoration: InputDecoration(
                  labelText: "Task Title",
                  labelStyle: TextStyle(fontSize: screenWidth * 0.04), 
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(screenWidth * 0.02), 
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.03), 

              ElevatedButton(
                onPressed: () {
                  final newTask = {
                    'title': _titleController.text,
                    'tags': ["New Task"],
                    'comments': 0,
                    'attachments': 0,
                  };

                  widget.onAddTask(newTask);
                  Navigator.pop(context, newTask);
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                    vertical: screenHeight * 0.02,
                    horizontal: screenWidth * 0.05,
                  ),
                  textStyle: TextStyle(fontSize: screenWidth * 0.045), 
                ),
                child: Text("Add Task"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
