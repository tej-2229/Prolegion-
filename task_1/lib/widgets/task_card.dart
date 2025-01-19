import 'package:flutter/material.dart';

class TaskCard extends StatelessWidget {
  final String title;
  final List<String> tags;
  final int comments;
  final int attachments;
  final List<ImageProvider> teamIcons;
  final VoidCallback onTap;

  const TaskCard({
    super.key,
    required this.title,
    required this.tags,
    required this.comments,
    required this.attachments,
    required this.teamIcons,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;

    final isWideScreen = screenWidth > 600; 

    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: EdgeInsets.symmetric(vertical: screenWidth * 0.02), 
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        elevation: 3,
        child: Padding(
          padding: EdgeInsets.all(screenWidth * 0.04), 
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              Text(
                title,
                style: TextStyle(
                  fontSize: isWideScreen ? screenWidth * 0.05 : 18, 
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: screenWidth * 0.02), 

              Wrap(
                spacing: screenWidth * 0.02, 
                children: tags
                    .map((tag) => Chip(
                          label: Text(
                            tag,
                            style: TextStyle(color: Colors.white),
                          ),
                          backgroundColor: Colors.blueAccent.withOpacity(0.7),
                        ))
                    .toList(),
              ),
              SizedBox(height: screenWidth * 0.03), 

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.comment, color: Colors.grey, size: screenWidth * 0.05), 
                      SizedBox(width: screenWidth * 0.02), 
                      Text(comments.toString(), style: TextStyle(fontSize: screenWidth * 0.04)), 
                      SizedBox(width: screenWidth * 0.04), 
                      Icon(Icons.attach_file, color: Colors.grey, size: screenWidth * 0.05),
                      SizedBox(width: screenWidth * 0.02), 
                      Text(attachments.toString(), style: TextStyle(fontSize: screenWidth * 0.04)), 
                    ],
                  ),

                  Row(
                    children: teamIcons.map((icon) {
                      return Padding(
                        padding: EdgeInsets.only(left: screenWidth * 0.02), 
                        child: CircleAvatar(
                          backgroundImage: icon,
                          radius: screenWidth * 0.07, 
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
