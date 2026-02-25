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
      title: 'Age Calculator App',
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData.dark(useMaterial3: true),
      home: const AgeCalculatorPage(),
    );
  }
}

class AgeCalculatorPage extends StatefulWidget {
  const AgeCalculatorPage({super.key});

  @override
  State<AgeCalculatorPage> createState() => _AgeCalculatorPageState();
}

class _AgeCalculatorPageState extends State<AgeCalculatorPage> {
  final TextEditingController _dobController = TextEditingController();
  String _result = "";

  void _calculateAge() {
    if (_dobController.text.isEmpty) {
      setState(() {
        _result = "Please enter your date of birth";
      });
      return;
    }
    try {
      DateTime dob = DateTime.parse(_dobController.text.trim());
      DateTime today = DateTime.now();

      if (dob.isAfter(today)) {
        setState(() {
          _result = "Date of birth cannot be in the future";
        });
        return;
      }
      int years = today.year - dob.year;
      int months = today.month - dob.month;
      int days = today.day - dob.day;

      if (days < 0) {
        months--;
        days += DateTime(today.year, today.month, 0).day;
      }
      if (months < 0) {
        years--;
        months += 12;
      }

      setState(() {
        _result = "You are $years years, $months months, and $days days old.";
      });
    } catch (e) {
      setState(() {
        _result = "Please enter date in yyyy-mm-dd format.";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Age Calculator",
          style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _dobController,
              keyboardType: TextInputType.datetime,
              decoration: const InputDecoration(
                labelText: "Enter your date of birth (yyyy-mm-dd)",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                icon: Icon(Icons.cake),

                prefixIcon: Icon(Icons.calendar_today),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _calculateAge,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 15,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                "Calculate Age",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 30),
            Text(
              _result,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: _result.contains("Please") || _result.contains("cannot")
                    ? Colors.redAccent
                    : Colors.greenAccent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
