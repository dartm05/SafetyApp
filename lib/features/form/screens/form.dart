import 'package:flutter/material.dart';

class FormPage extends StatefulWidget {
  const FormPage({Key? key}) : super(key: key);

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final _formKey = GlobalKey<FormState>();

  String? _mood;
  String? _energyLevel;
  double _sleepQuality = 5;
  bool _hotFlashes = false;
  bool _nightSweats = false;
  bool _irritability = false;

  final List<String> _moodOptions = [
    'Happy',
    'Anxious',
    'Irritable',
    'Depressed',
    'Neutral'
  ];
  final List<String> _energyOptions = [
    'Very Low',
    'Low',
    'Moderate',
    'High',
    'Very High'
  ];

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Symptoms recorded successfully!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    const sizedBox = SizedBox(height: 40);
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 40.0),
            child: const Text(
              'How are you feeling today?',
              style: TextStyle(fontSize: 24),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                sizedBox,
                Padding(
                  padding:
                      const EdgeInsets.only(top: 34.0, left: 20.0, right: 20.0),
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 600),
                    child: Form(
                      key: _formKey,
                      child: ListView(
                        shrinkWrap: true,
                        children: [
                          DropdownButtonFormField<String>(
                            decoration: const InputDecoration(
                              labelText: 'Mood',
                            ),
                            value: _mood,
                            items: _moodOptions
                                .map((mood) => DropdownMenuItem(
                                    value: mood, child: Text(mood)))
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                _mood = value;
                              });
                            },
                            validator: (value) => value == null
                                ? 'Please select your mood'
                                : null,
                          ),
                          sizedBox,
                          DropdownButtonFormField<String>(
                            decoration: const InputDecoration(
                                labelText: 'Energy Level'),
                            value: _energyLevel,
                            items: _energyOptions
                                .map((level) => DropdownMenuItem(
                                    value: level, child: Text(level)))
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                _energyLevel = value;
                              });
                            },
                            validator: (value) => value == null
                                ? 'Please select your energy level'
                                : null,
                          ),
                          sizedBox,
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Sleep Quality'),
                                Slider(
                                  value: _sleepQuality,
                                  min: 1,
                                  max: 10,
                                  divisions: 9,
                                  label: _sleepQuality.round().toString(),
                                  onChanged: (value) {
                                    setState(() {
                                      _sleepQuality = value;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                          sizedBox,
                          CheckboxListTile(
                            title: const Text('Hot Flashes'),
                            value: _hotFlashes,
                            onChanged: (value) {
                              setState(() {
                                _hotFlashes = value!;
                              });
                            },
                          ),
                          CheckboxListTile(
                            title: const Text('Night Sweats'),
                            value: _nightSweats,
                            onChanged: (value) {
                              setState(() {
                                _nightSweats = value!;
                              });
                            },
                          ),
                          CheckboxListTile(
                            title: const Text('Irritability'),
                            value: _irritability,
                            onChanged: (value) {
                              setState(() {
                                _irritability = value!;
                              });
                            },
                          ),
                          sizedBox,
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 16.0, horizontal: 20),
                            child: ElevatedButton(
                              onPressed: _submitForm,
                              child: const Text('Submit'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
