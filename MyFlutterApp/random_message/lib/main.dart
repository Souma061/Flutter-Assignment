import 'dart:math';

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
      title: 'Random Message App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const RandomMessage(),
    );
  }
}

class RandomMessage extends StatefulWidget {
  const RandomMessage({super.key});

  @override
  State<RandomMessage> createState() => _RandomMessageState();
}

class _RandomMessageState extends State<RandomMessage> {
  final List<String> _messages = [
    'Hello, World!',
    'Welcome to Flutter.',
    'Flutter is awesome!',
    'Have a great day!',
    'Keep coding!',
  ];
  int _currentIndex = 0;

  void _updateMessage() {
    setState(() {
      _currentIndex = Random().nextInt(_messages.length);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Random Message Switcher')),
      body: Center(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          ),
          onPressed: _updateMessage, // Trigger the logic on press
          child: Text(
            _messages[_currentIndex], // Display current message
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      ),
    );
  }
}
