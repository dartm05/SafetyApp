import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safety_app/src/data/models/profile.dart';

import '../providers/profile_provider.dart';

class ProfileForm extends StatefulWidget {
  const ProfileForm({super.key});

  @override
  State<ProfileForm> createState() => _ProfileFormState();
}

class _ProfileFormState extends State<ProfileForm> {
  final _formKey = GlobalKey<FormState>();

  String? _gender;
  String? _age;
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

  @override
  void initState() {
    super.initState();
    final profileProvider =
        Provider.of<ProfileProvider>(context, listen: false);
    profileProvider.getProfile().then((value) {
      Profile? profile = profileProvider.profile;
      _gender = profile?.gender;
      _age = profile?.age.toString();
      _ethnicity = profile?.ethnicity;
      _disability = profile?.disability ?? false;
      _preferredModeOfTransport = profile?.preferredModeOfTransport;
      _dataUsage = profile?.dataUsage;
      _travelingWithChildren = profile?.travelingWithChildren ?? false;
    });
  }

  void _saveProfile(BuildContext context) {
    final profileProvider =
        Provider.of<ProfileProvider>(context, listen: false);
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final newProfile = Profile(
        age: int.parse(_age!),
        gender: _gender!,
        ethnicity: _ethnicity!,
        dataUsage: _dataUsage!,
        disability: _disability,
        travelingWithChildren: _travelingWithChildren,
        preferredModeOfTransport: _preferredModeOfTransport!,
      );

      if (profileProvider.profile != null) {
        profileProvider.updateProfile(newProfile);
      } else {
        profileProvider.createProfile(newProfile);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    SizedBox sizedBox = width > 800
        ? SizedBox(
            height: 60,
          )
        : SizedBox(height: 20);
    const sizedboxM = SizedBox(height: 10);
    final profileProvider = Provider.of<ProfileProvider>(context, listen: true);
    return !profileProvider.isLoading
        ? Scaffold(
            body: ListView(
              shrinkWrap: true,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 40.0),
                  child: Center(
                    child: Text(
                      'Profile Form',
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                ),
                Center(
                  child: SizedBox(
                    width: width > 800 ? 700 : width,
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        sizedBox,
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 20.0, right: 20.0),
                          child: Container(
                            constraints: const BoxConstraints(maxWidth: 600),
                            child: Form(
                              key: _formKey,
                              child: ListView(
                                shrinkWrap: true,
                                children: [
                                  DropdownButtonFormField<String>(
                                    key: const Key('gender'),
                                    decoration: const InputDecoration(
                                        labelText: 'Gender'),
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
                                    decoration:
                                        const InputDecoration(labelText: 'Age'),
                                    keyboardType: TextInputType.number,
                                    initialValue: _age,
                                    onSaved: (value) {
                                      _age = value!;
                                    },
                                    validator: (value) => value!.isEmpty
                                        ? 'Please enter your age'
                                        : null,
                                  ),
                                  sizedBox,
                                  DropdownButtonFormField<String>(
                                    key: const Key('ethnicity'),
                                    decoration: const InputDecoration(
                                        labelText: 'Ethnicity'),
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
                                    title:
                                        const Text('Traveling with Children'),
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
                                        labelText:
                                            'Preferred Mode of Transportation'),
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
                                    decoration: const InputDecoration(
                                        labelText: 'Data Usage'),
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
                                    onPressed: () => _saveProfile(context),
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
                ),
              ],
            ),
          )
        : const Center(child: CircularProgressIndicator());
  }
}
