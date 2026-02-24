import 'package:flutter/material.dart';

void main() => runApp(const VoterApp());

class Person {
  final String name;
  final int age;
  Person(this.name, this.age);
}

class VoterApp extends StatelessWidget {
  const VoterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData.dark(useMaterial3: true),
      home: const VoterScreen(),
    );
  }
}

class VoterScreen extends StatefulWidget {
  const VoterScreen({super.key});

  @override
  State<VoterScreen> createState() => _VoterScreenState();
}

class _VoterScreenState extends State<VoterScreen> {
  final List<Person> _people = [];
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();

  void _addPerson() {
    final name = _nameController.text;
    final age = int.tryParse(_ageController.text);

    if (name.isNotEmpty && age != null) {
      setState(() {
        _people.add(Person(name, age));
        _nameController.clear();
        _ageController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Logic using toList and map as requested
    List<Person> eligible = _people.where((p) => p.age >= 18).toList();
    List<Person> ineligible = _people.where((p) => p.age < 18).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Voter Eligibility Tracker')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _ageController,
              decoration: const InputDecoration(labelText: 'Age'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _addPerson,
              child: const Text('Add Person'),
            ),
            const Divider(),
            Expanded(
              child: Row(
                children: [
                  _buildListColumn("Eligible", eligible, Colors.green),
                  const VerticalDivider(),
                  _buildListColumn(
                    "Not Eligible",
                    ineligible,
                    Colors.redAccent,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListColumn(String title, List<Person> list, Color color) {
    return Expanded(
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, color: color),
          ),
          Expanded(
            child: ListView(
              // Using .map().toList() to build widgets
              children: list
                  .map(
                    (p) => ListTile(
                      title: Text(p.name),
                      subtitle: Text('Age: ${p.age}'),
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
