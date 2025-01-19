Task Manager App:

Project Overview:
The Task Manager app is a Flutter-based application designed to manage tasks efficiently. It includes features such as task creation, task filtering, and task details. The app is integrated with an external API for fetching tasks, ensuring real-time updates and reliable data management.

Steps to Run the Project:
1. Clone the Repository:
   git clone <repository_url>
   cd <project_directory>
2. Install Flutter:
   Ensure that Flutter is installed on your system. You can follow the official Flutter installation guide.
3. Install Dependencies:
   Navigate to the project directory and run:
   flutter pub get
4. Run the App:
   Connect your device or start an emulator.
   Run the app using:
   flutter run
5. Build for Production:
   To create a release build for Android or iOS, follow the respective Flutter documentation:
     Build and release for Android
     Build and release for iOS

Approach to the Task
1. Design:
  The app follows a clean and intuitive user interface with Material Design principles.
  Responsive design ensures compatibility across various screen sizes and devices.

2. State Management:
  Used StatefulWidget to manage state locally within the app.
  Tasks are fetched and managed using asynchronous operations with FutureBuilder.

3. Task Management:
  Implemented task creation with a form (AddTaskScreen).
  Tasks can be filtered based on tags (e.g., "UI Design", "Project", etc.) via a bottom sheet filter.
  Task details are displayed on a dedicated screen (TaskDetailsScreen).

4. Reusability:
    The TaskCard widget is designed for reuse, displaying task details compactly and interactively.

API Integration
Description:
  The app integrates with a RESTful API to manage task data. The API is responsible for fetching, creating, and updating tasks.

Features:
1. Fetching Tasks:
  The ApiService.fetchTasks() method retrieves a list of tasks from the API.
  Tasks are displayed in a list format using FutureBuilder for asynchronous data handling.

2. Adding Tasks:
  A new task can be created using the AddTaskScreen.
  The task is added locally, and the API can be extended to support remote task creation.

3. Filtering Tasks:
  Tasks are filtered based on tags (e.g., "UI Design", "Bug Fix").
  This filtering is applied locally after fetching tasks from the API.
