# Student Accommodation Information Form

A Flutter application designed to collect student accommodation information.

## Features

- **User Authentication Fields**: Username and password fields for basic authentication.
- **Laptop Status**: Radio buttons to indicate whether the student has a laptop.
- **Program Selection**: Dropdown menu to select the student's program (IS, CS, SE, DS at UCSC).
- **Accommodation Requests**: Checkbox for specific accommodation needs, which dynamically reveals a text area for more details.
- **Form Validation**: Ensures required fields are filled and passwords meet minimum length requirements.
- **Results Display**: Displays a summary of the entered information upon successful submission.

## Getting Started

This project is a starting point for a Flutter application.

### Prerequisites
- [Flutter SDK](https://docs.flutter.dev/get-started/install)
- Dart SDK

### Running the App
1. Clone the repository or extract the project files.
2. Navigate to the project directory:
   ```bash
   cd Student-accommodation-information-form
   ```
3. Get the dependencies:
   ```bash
   flutter pub get
   ```
4. Run the application:
   ```bash
   flutter run
   ```

## Development Highlights

- Built using the Flutter framework with Dart.
- State management utilizing `StatefulWidget`.
- Custom UI layout including `Form`, `TextFormField`, `Radio`, `DropdownButtonFormField`, and `Checkbox`.
- Specific styling with an amber theme (`Colors.amber`).
