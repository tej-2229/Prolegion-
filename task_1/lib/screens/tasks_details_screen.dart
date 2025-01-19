import 'package:flutter/material.dart';

class TaskDetailsScreen extends StatelessWidget {
  final dynamic task;

  const TaskDetailsScreen({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;
    final isWideScreen = screenWidth > 600; 

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Task Details",
          style: TextStyle(fontSize: screenWidth * 0.05), 
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(screenWidth * 0.04), 
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Task Title
              Text(
                "Title: ${task['title']}",
                style: TextStyle(
                  fontSize: isWideScreen ? 24 : 20, 
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: screenHeight * 0.02), 

              Text(
                "Completed: ${task['completed'] ? "Yes" : "No"}",
                style: TextStyle(
                  fontSize: isWideScreen ? 20 : 16, 
                ),
              ),

              SizedBox(height: screenHeight * 0.03),

            ],
          ),
        ),
      ),
    );
  }
}
