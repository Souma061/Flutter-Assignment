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
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
      ),
      home: const WeatherScreen(),
    );
  }
}

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final TextEditingController _inputController = TextEditingController();
  String _fromUnit = 'Celsius';
  String _toUnit = 'Fahrenheit';
  String _result = '';

  final List<String> _units = ['Celsius', 'Fahrenheit', 'Kelvin'];
  void _convert() {
    double? input = double.tryParse(_inputController.text);
    if (input == null) {
      setState(() => _result = 'Invalid input');
      return;
    }

    double celsius;
    // Use .toLowerCase() to ensure the switch matches the lowercase cases
    switch (_fromUnit.toLowerCase()) {
      case 'fahrenheit':
        celsius = (input - 32) * 5 / 9;
        break;
      case 'kelvin':
        celsius = input - 273.15;
        break;
      default: // This handles 'celsius'
        celsius = input;
        break;
    }

    double finalValue;
    switch (_toUnit.toLowerCase()) {
      case 'fahrenheit':
        finalValue = (celsius * 9 / 5) + 32;
        break;
      case 'kelvin':
        finalValue = celsius + 273.15;
        break;
      default: // This handles 'celsius'
        finalValue = celsius;
        break;
    }

    setState(() {
      _result = '$input $_fromUnit = ${finalValue.toStringAsFixed(2)} $_toUnit';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Weather App',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _inputController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Enter temperature',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                DropdownButton<String>(
                  value: _fromUnit,
                  items: [
                    for (var unit in _units)
                      DropdownMenuItem(value: unit, child: Text(unit)),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _fromUnit = value!;
                    });
                  },
                ),
                DropdownButton<String>(
                  value: _toUnit,
                  items: [
                    for (var unit in _units)
                      DropdownMenuItem(value: unit, child: Text(unit)),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _toUnit = value!;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            ElevatedButton(onPressed: _convert, child: const Text('Convert')),
            const SizedBox(height: 16),
            Text(_result, style: const TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
