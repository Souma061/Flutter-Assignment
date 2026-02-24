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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const ColorChangerScreen(),
    );
  }
}

class ColorChangerScreen extends StatefulWidget {
  const ColorChangerScreen({super.key});

  @override
  State<ColorChangerScreen> createState() => _ColorChangerScreenState();
}

class _ColorChangerScreenState extends State<ColorChangerScreen> {
  Color _backgroundColor = Colors.white;

  void _changeColor(Color color) {
    setState(() {
      _backgroundColor = color;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      appBar: AppBar(
        title: const Text('Color Changer'),
        backgroundColor: Colors.white70,
        foregroundColor: Colors.black,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Press the buttons to change the background color',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _changeColor(Colors.red),
              child: const Text('Red'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => _changeColor(Colors.green),
              child: const Text('Green'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => _changeColor(Colors.blue),
              child: const Text('Blue'),
            ),
          ],
        ),
      ),
    );
  }
}
