import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Leap Year Check App',
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData.dark(useMaterial3: true),
      home: const LeapYearPage(),
    );
  }
}

class LeapYearPage extends StatefulWidget {
  const LeapYearPage({super.key});

  @override
  State<LeapYearPage> createState() => _LeapYearPageState();
}

class _LeapYearPageState extends State<LeapYearPage> {
  final TextEditingController _yearController = TextEditingController();
  String _result = '';

  void _checkLeapYear() {
    final int? year = int.tryParse(_yearController.text);
    if (year == null) {
      setState(() {
        _result = 'Please enter a valid year.';
      });
      return;
    }
    bool isLeapYear = (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0);
    setState(() {
      if (isLeapYear) {
        _result = '$year is a leap year.';
      } else {
        _result = '$year is not a leap year.';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Leap Year Checker',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _yearController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Enter a year',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _checkLeapYear,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 15,
                ),
              ),
              child: const Text(
                'Check',
                style: TextStyle(fontSize: 18, letterSpacing: 1.2),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              _result,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
