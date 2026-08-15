import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    title: 'Student Accommodation Form',
    home: StudentAccommodationForm(),
  ));
}

class StudentAccommodationForm extends StatefulWidget {
  const StudentAccommodationForm({Key? key}) : super(key: key);

  @override
  _StudentAccommodationFormState createState() =>
      _StudentAccommodationFormState();
}

class _StudentAccommodationFormState extends State<StudentAccommodationForm> {
  final _formKey = GlobalKey<FormState>();
  
  // Form Field Controllers
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _accommodationNeedsController = TextEditingController();

  // State variables
  bool _hasLaptop = true; 
  String _selectedCourse = 'IS';
  bool _hasAccommodationRequest = false;
  
  String _resultMessage = '';

  // Dropdown options
  final List<String> _courses = ['IS', 'CS'];

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        String laptopText = _hasLaptop ? "do" : "don't";
        _resultMessage = "Your username is ${_usernameController.text}. "
            "You $laptopText have Laptop\n"
            "You are a $_selectedCourse student at UCSC";
            
        if (_hasAccommodationRequest && _accommodationNeedsController.text.isNotEmpty) {
          _resultMessage += "\nAccommodation Needs: ${_accommodationNeedsController.text}";
        }
      });
    }
  }

  void _clearForm() {
    _formKey.currentState!.reset();
    _usernameController.clear();
    _passwordController.clear();
    _accommodationNeedsController.clear();
    setState(() {
      _hasLaptop = true;
      _selectedCourse = 'IS';
      _hasAccommodationRequest = false;
      _resultMessage = '';
    });
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _accommodationNeedsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber, // Special requirement: Screen color is amber
      appBar: AppBar(
        title: const Text('Student Information'),
        backgroundColor: Colors.amber[700],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Username Field
              TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: 'Username',
                  hintText: 'Username',
                  prefixIcon: const Icon(Icons.face),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  filled: true,
                  fillColor: Colors.white, // Adding fill for readability on amber
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Username must not be empty'; // Validation for username
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              
              // Password Field
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  hintText: 'Password',
                  prefixIcon: const Icon(Icons.password),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
                validator: (value) {
                  if (value == null || value.length < 8) {
                    return 'Password must not be less than eight characters'; // Validation for password
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),

              // Laptop Radio Buttons
              const Text(
                'Do you have a Laptop?',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              Row(
                children: [
                  Radio<bool>(
                    value: true,
                    groupValue: _hasLaptop,
                    onChanged: (bool? value) {
                      setState(() {
                        _hasLaptop = value!;
                      });
                    },
                  ),
                  const Text('Yes'),
                  const SizedBox(width: 20),
                  Radio<bool>(
                    value: false,
                    groupValue: _hasLaptop,
                    onChanged: (bool? value) {
                      setState(() {
                        _hasLaptop = value!;
                      });
                    },
                  ),
                  const Text('No'),
                ],
              ),
              const SizedBox(height: 16),

              // IS Student Dropdown
              const Text(
                'Select your program:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              DropdownButtonFormField<String>(
                value: _selectedCourse,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
                items: _courses.map((String course) {
                  return DropdownMenuItem<String>(
                    value: course,
                    child: Text(course),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedCourse = newValue!;
                  });
                },
              ),
              const SizedBox(height: 16),

              // Accommodation Request Checkbox
              Row(
                children: [
                  Checkbox(
                    value: _hasAccommodationRequest,
                    onChanged: (bool? value) {
                      setState(() {
                        _hasAccommodationRequest = value!;
                      });
                    },
                  ),
                  const Expanded(
                    child: Text(
                      'I have specific accommodation requests',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              
              // Conditional Additional Text Field for Accommodation Needs
              if (_hasAccommodationRequest)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                  child: TextFormField(
                    controller: _accommodationNeedsController,
                    maxLines: 3,
                    decoration: InputDecoration(
                      labelText: 'Describe your accommodation needs',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                ),
              
              const SizedBox(height: 24),

              // Submit and Clear Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: _submitForm,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                    ),
                    child: const Text('Submit', style: TextStyle(fontSize: 16)),
                  ),
                  ElevatedButton(
                    onPressed: _clearForm,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[300], // distinct color for clear
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                    ),
                    child: const Text('Clear', style: TextStyle(fontSize: 16)),
                  ),
                ],
              ),
              
              const SizedBox(height: 32),

              // Bottom Display Message Area
              if (_resultMessage.isNotEmpty)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black12),
                  ),
                  child: Text(
                    _resultMessage,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
