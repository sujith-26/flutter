import 'package:flutter/material.dart';

void main() {
  runApp(AgeCalculatorApp());
}

class AgeCalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Age Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AgeCalculatorHome(),
    );
  }
}

class AgeCalculatorHome extends StatefulWidget {
  @override
  _AgeCalculatorHomeState createState() => _AgeCalculatorHomeState();
}

class _AgeCalculatorHomeState extends State<AgeCalculatorHome> {
  DateTime? _selectedDate;
  String _age = '';

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
        _age = _calculateAge(_selectedDate!);
      });
    });
  }

  String _calculateAge(DateTime birthDate) {
    DateTime today = DateTime.now();
    int age = today.year - birthDate.year;
    if (today.month < birthDate.month ||
        (today.month == birthDate.month && today.day < birthDate.day)) {
      age--;
    }
    return age.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Age Calculator'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Select your date of birth:',
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _presentDatePicker,
              child: Text('Choose Date'),
            ),
            SizedBox(height: 20),
            Text(
              _selectedDate == null
                  ? 'No Date Chosen!'
                  : 'Date of Birth: ${_selectedDate!.toLocal()}'.split(' ')[0],
            ),
            SizedBox(height: 20),
            Text(
              _selectedDate == null ? '' : 'Your age is: $_age',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
