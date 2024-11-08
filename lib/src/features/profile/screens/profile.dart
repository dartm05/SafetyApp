import 'package:flutter/material.dart';

class ProfileForm extends StatefulWidget {
  const ProfileForm({Key? key}) : super(key: key);

  @override
  State<ProfileForm> createState() => _ProfileFormState();
}

class _ProfileFormState extends State<ProfileForm> {
  final _formKey = GlobalKey<FormState>();

  String? _gender;
  String _age = '';
  String? _ethnicity;
  bool _disability = false;
  String? _preferredModeOfTransport;
  String? _dataUsage;
  bool _travelingWithChildren = false;

  final List<String> _genderOptions = ['Male', 'Female', 'Other'];
  final List<String> _transportOptions = [
    'Car',
    'Bike',
    'Public Transport',
    'Walking'
  ];
  final List<String> _dataUsageOptions = ['Data Roaming', 'Local SIM'];

  final List<String> _ethnicityOptions = [
    'White',
    'Black',
    'Hispanic',
    'Asian',
    'Other'
  ];

  void _saveProfile() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile saved successfully!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    const sizedBox = SizedBox(height: 20);
    const sizedboxM = SizedBox(height: 10);
    return Scaffold(
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 40.0),
            child: Text(
              'Profile Form',
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
                            key: const Key('gender'),
                            decoration:
                                const InputDecoration(labelText: 'Gender'),
                            value: _gender,
                            items: _genderOptions
                                .map((gender) => DropdownMenuItem(
                                      value: gender,
                                      child: Text(gender),
                                    ))
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                _gender = value!;
                              });
                            },
                          ),
                          sizedBox,
                          TextFormField(
                            initialValue: _age,
                            decoration: const InputDecoration(labelText: 'Age'),
                            keyboardType: TextInputType.number,
                            onSaved: (value) {
                              _age = value ?? '';
                            },
                            validator: (value) =>
                                value!.isEmpty ? 'Please enter your age' : null,
                          ),
                          sizedBox,
                          DropdownButtonFormField<String>(
                            key: const Key('ethnicity'),
                            decoration:
                                const InputDecoration(labelText: 'Ethnicity'),
                            value: _ethnicity,
                            items: _ethnicityOptions
                                .map((ethnic) => DropdownMenuItem(
                                      value: ethnic,
                                      child: Text(ethnic),
                                    ))
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                _ethnicity = value!;
                              });
                            },
                            validator: (value) => value!.isEmpty
                                ? 'Please enter your ethnicity'
                                : null,
                          ),
                          sizedBox,
                          SwitchListTile(
                            title: const Text('Disability'),
                            value: _disability,
                            onChanged: (value) {
                              setState(() {
                                _disability = value;
                              });
                            },
                          ),
                          sizedboxM,
                          SwitchListTile(
                            title: const Text('Traveling with Children'),
                            value: _travelingWithChildren,
                            onChanged: (value) {
                              setState(() {
                                _travelingWithChildren = value;
                              });
                            },
                          ),
                          sizedBox,
                          DropdownButtonFormField<String>(
                            key: const Key('preferredModeOfTransport'),
                            decoration: const InputDecoration(
                                labelText: 'Preferred Mode of Transportation'),
                            value: _preferredModeOfTransport,
                            items: _transportOptions
                                .map((transport) => DropdownMenuItem(
                                      value: transport,
                                      child: Text(transport),
                                    ))
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                _preferredModeOfTransport = value!;
                              });
                            },
                          ),
                          sizedBox,
                          DropdownButtonFormField<String>(
                            key: const Key('dataUsage'),
                            decoration:
                                const InputDecoration(labelText: 'Data Usage'),
                            value: _dataUsage,
                            items: _dataUsageOptions
                                .map((usage) => DropdownMenuItem(
                                      value: usage,
                                      child: Text(usage),
                                    ))
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                _dataUsage = value!;
                              });
                            },
                          ),
                          sizedBox,
                          ElevatedButton(
                            onPressed: _saveProfile,
                            child: const Text('Save Profile'),
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
