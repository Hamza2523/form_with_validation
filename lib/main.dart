import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Form Validation',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _formKey = GlobalKey<FormState>();

  // Form field variables
  String _firstName = '';
  String _middleName = '';
  String _lastName = '';
  int _age = 0;
  String _email = '';
  String _phoneNumber = '';

  // Validation functions
  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
    return null;
  }

  String? _validateAge(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your age';
    }
    int? age = int.tryParse(value);
    if (age == null || age <= 0) {
      return 'Please enter a valid age';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  String? _validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your phone number';
    }
    if (!RegExp(r'^\+?[0-9]{10,13}$').hasMatch(value)) {
      return 'Please enter a valid phone number';
    }
    return null;
  }

  // Save form data
  void _saveForm() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Form submitted successfully!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Form Validation Example'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'First Name'),
                validator: _validateName,
                onSaved: (value) {
                  _firstName = value ?? '';
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Middle Name'),
                onSaved: (value) {
                  _middleName = value ?? '';
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Last Name'),
                validator: _validateName,
                onSaved: (value) {
                  _lastName = value ?? '';
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Age'),
                keyboardType: TextInputType.number,
                validator: _validateAge,
                onSaved: (value) {
                  _age = int.tryParse(value ?? '0') ?? 0;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Email'),
                validator: _validateEmail,
                onSaved: (value) {
                  _email = value ?? '';
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Phone Number'),
                keyboardType: TextInputType.phone,
                validator: _validatePhoneNumber,
                onSaved: (value) {
                  _phoneNumber = value ?? '';
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveForm,
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
