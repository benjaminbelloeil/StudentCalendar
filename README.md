# StudentCalendar App

## Overview

The StudentCalendar app is a Swift-based iOS application designed to help students manage their class schedules efficiently. The app allows users to add, edit, and delete classes while viewing their schedules in a clean and intuitive interface. Additionally, the app includes a profile management feature where students can update their personal information.

## Features

### Home Screen

- **Current Week View**: Displays the current week with the option to view tasks for each day.
- **Task Cards**: Show detailed information about each class, including title, description, location, and time.
- **Edit Button**: Allows the user to quickly edit any task.
- **Delete Button**: Easily remove tasks from the schedule.
- **Add Task**: A floating action button allows the user to add a new class to their schedule.

### Profile Screen

- **Profile Information**: Displays student details like name, email, phone, and location.
- **Edit Profile**: Allows the user to update their profile information, including changing the profile picture.

## Installation

### Prerequisites

- Xcode 12 or later
- iOS 14.0 or later
- Swift 5

### Steps to Install

1. **Clone the Repository**  
   ```bash
   git clone https://github.com/your-username/StudentCalendar.git

2. **Open the Project**
   - Navigate to the `StudentCalendar` directory and open the `StudentCalendar.xcodeproj` file in Xcode.

3. **Run the App**
   - Select the target device or simulator.
   - Click the Run button (or press Cmd + R) in Xcode.

## Usage

### Adding a New Task

1. Tap the ”+” button on the bottom right of the Home screen.
2. Fill in the class details such as title, description, start time, end time, and color.
3. Tap the “Add Class” button to save.

### Editing a Task

1. Tap the pencil icon on the task card you wish to edit.
2. Update the details as necessary.
3. Tap the “Save Changes” button.

### Deleting a Task

1. Tap the trash icon on the task card you wish to delete.
2. Confirm deletion (if prompted).

### Viewing and Editing Profile

1. Navigate to the Profile tab.
2. Tap the “Edit Profile” button.
3. Update your profile information and save changes.

## Project Structure
StudentCalendar/
├── `StudentCalendarApp.swift`  # App entry point
├── `Home.swift`                # Main screen displaying the class schedule
├── `AddTaskView.swift`         # View for adding and editing tasks
├── `Task.swift`                # Task model defining the structure of a class
├── `TaskViewModel.swift`       # ViewModel handling the business logic
├── `StudentProfile.swift`      # Profile screen displaying user information
├── `EditProfileView.swift`     # View for editing the user's profile information
├── `ImagePicker.swift`         # Utility for picking a profile image
├── `ContentView.swift`         # Tab view containing Home and Profile tabs
└── `Assets.xcassets`           # Image and color assets used in the app

## Dependencies

This project does not use any external dependencies or libraries. All features are implemented using SwiftUI and Swift’s standard library.

## Screenshots

- The Home screen displays the current schedule.
- The Edit Profile screen allows updating user details.

## Future Improvements

- **Notifications**: Implement push notifications to remind students of upcoming classes.
- **Calendar Integration**: Sync the schedule with the iOS Calendar app.
- **Customizable Themes**: Allow users to change the app’s theme and colors.

## Contributing

1. Fork the repository.
2. Create a new branch (`git checkout -b feature-branch`).
3. Make your changes.
4. Commit your changes (`git commit -am 'Add new feature'`).
5. Push to the branch (`git push origin feature-branch`).
6. Create a new Pull Request.
