import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData.dark(useMaterial3: true),
      home: const StopWatchPage(),
    );
  }
}

class StopWatchPage extends StatefulWidget {
  const StopWatchPage({super.key});

  @override
  State<StopWatchPage> createState() => _StopWatchPageState();
}

class _StopWatchPageState extends State<StopWatchPage> {
  final Stopwatch _stopwatch = Stopwatch();
  late Timer _timer;
  String _result = '00:00:00';

  @override
  void dispose() {
    if (_stopwatch.isRunning) {
      _timer.cancel();
    }
    super.dispose();
  }

  //start stopwatch
  void _startStopWatch() {
    _stopwatch.start();
    _timer = Timer.periodic(const Duration(milliseconds: 30), (Timer t) {
      setState(() {
        _result = _formatTime(_stopwatch.elapsedMilliseconds);
      });
    });
  }

  //stop stopwatch
  void _stopStopWatch() {
    _stopwatch.stop();
    _timer.cancel();
    setState(() {});
  }

  void _resetStopWatch() {
    _stopwatch.reset();
    _stopwatch.stop();
    setState(() {
      _result = '00:00:00';
    });
  }

  String _formatTime(int milliseconds) {
    int hundreds = (milliseconds / 10).truncate() % 100;
    int seconds = (milliseconds / 1000).truncate() % 60;
    int minutes = (milliseconds / (1000 * 60)).truncate() % 60;

    String minuteStr = minutes.toString().padLeft(2, '0');
    String secondStr = seconds.toString().padLeft(2, '0');
    String hundredStr = hundreds.toString().padLeft(2, '0');

    return "$minuteStr:$secondStr:$hundredStr";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stop Watch'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 6,
            child: Text(
              _result,
              style: const TextStyle(
                fontSize: 60,
                fontWeight: FontWeight.w200,
                fontFeatures: [FontFeature.tabularFigures()],
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildButton(
                  color: Colors.grey[800]!,
                  textColor: Colors.white,
                  text: "Reset",
                  onPressed: _resetStopWatch,
                ),
                _buildButton(
                  color: _stopwatch.isRunning
                      ? Colors.red[900]!
                      : Colors.green[900]!,
                  textColor: _stopwatch.isRunning
                      ? Colors.red[300]!
                      : Colors.green[300]!,
                  text: _stopwatch.isRunning ? "Stop" : "Start",
                  onPressed: _stopwatch.isRunning
                      ? _stopStopWatch
                      : _startStopWatch,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildButton({
  required Color color,
  required Color textColor,
  required String text,
  required VoidCallback onPressed,
}) {
  return SizedBox(
    height: 100,
    width: 100,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: const CircleBorder(),
        padding: const EdgeInsets.all(20),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontSize: 20,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
  );
}
