import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final _formKey = GlobalKey<FormState>();

  String _name = '';
  String _email = '';
  bool _emailNotifications = true;
  bool _pushNotifications = true;
  String _trackingFrequency = 'Daily';

  final List<String> _frequencyOptions = ['Daily', 'Weekly', 'Monthly'];

  void _saveSettings() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Settings saved successfully!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    const sizedBox = SizedBox(height: 40);
    return Scaffold(
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 40.0),
            child: Text(
              'Settings',
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
                          TextFormField(
                            initialValue: _name,
                            decoration: const InputDecoration(labelText: 'Name'),
                            onSaved: (value) {
                              _name = value ?? '';
                            },
                            validator: (value) =>
                                value!.isEmpty ? 'Please enter your name' : null,
                          ),
                          sizedBox,
                          TextFormField(
                            initialValue: _email,
                            decoration: const InputDecoration(labelText: 'Email'),
                            keyboardType: TextInputType.emailAddress,
                            onSaved: (value) {
                              _email = value ?? '';
                            },
                            validator: (value) =>
                                value!.isEmpty ? 'Please enter your email' : null,
                          ),
                          sizedBox,
                          SwitchListTile(
                            title: const Text('Email Notifications'),
                            value: _emailNotifications,
                            onChanged: (value) {
                              setState(() {
                                _emailNotifications = value;
                              });
                            },
                          ),
                          SwitchListTile(
                            title: const Text('Push Notifications'),
                            value: _pushNotifications,
                            onChanged: (value) {
                              setState(() {
                                _pushNotifications = value;
                              });
                            },
                          ),
                          sizedBox,
                          DropdownButtonFormField<String>(
                            decoration: const InputDecoration(
                                labelText: 'Tracking Frequency'),
                            value: _trackingFrequency,
                            items: _frequencyOptions
                                .map((frequency) => DropdownMenuItem(
                                      value: frequency,
                                      child: Text(frequency),
                                    ))
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                _trackingFrequency = value!;
                              });
                            },
                          ),
                         sizedBox,
                          ElevatedButton(
                            onPressed: _saveSettings,
                            child: const Text('Save Settings'),
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
