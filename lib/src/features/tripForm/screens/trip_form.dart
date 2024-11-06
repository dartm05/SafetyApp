import 'package:flutter/material.dart';
import 'package:menopause_app/src/features/tripForm/providers/trip_form_provider.dart';
import 'package:provider/provider.dart';

class TripFormPage extends StatefulWidget {
  const TripFormPage({Key? key}) : super(key: key);

  @override
  State<TripFormPage> createState() => _TripFormPageState();
}

class _TripFormPageState extends State<TripFormPage> {
  final _formKey = GlobalKey<FormState>();

  String? _destination;
  DateTime? _startDate;
  DateTime? _endDate;
  String? _transportation;
  bool _accommodation = false;
  bool _activities = false;

  final List<String> _transportationOptions = [
    'Car',
    'Plane',
    'Train',
    'Bus',
    'Other'
  ];

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Trip details recorded successfully!')),
      );
    }
  }

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != (isStartDate ? _startDate : _endDate)) {
      setState(() {
        if (isStartDate) {
          _startDate = picked;
        } else {
          _endDate = picked;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    const sizedBox = SizedBox(height: 40);
    final tripFormProvider = Provider.of<TripFormProvider>(context);
    return Scaffold(
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 40.0),
            child: Center(
              child: Text(
                'Trip Details',
                style: TextStyle(fontSize: 24),
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
                          Autocomplete<String>(
                            optionsBuilder:
                                (TextEditingValue textEditingValue) async {
                              if (textEditingValue.text.isEmpty) {
                                tripFormProvider.clearPlacesList();
                                return const Iterable<String>.empty();
                              }
                              await tripFormProvider
                                  .fetchPlaces(textEditingValue.text);
                              return tripFormProvider.placesList;
                            },
                            onSelected: (String selection) {
                              _destination = selection;
                            },
                            fieldViewBuilder: (BuildContext context,
                                TextEditingController textEditingController,
                                FocusNode focusNode,
                                VoidCallback onFieldSubmitted) {
                              return TextFormField(
                                controller: textEditingController,
                                focusNode: focusNode,
                                decoration: const InputDecoration(
                                  labelText: 'Destination',
                                ),
                                validator: (value) =>
                                    value == null || value.isEmpty
                                        ? 'Please enter your destination'
                                        : null,
                              );
                            },
                          ),
                          sizedBox,
                          ListTile(
                            title: const Text('Start Date'),
                            subtitle: Text(
                              _startDate != null
                                  ? _startDate!
                                      .toLocal()
                                      .toString()
                                      .split(' ')[0]
                                  : 'Select a date',
                            ),
                            onTap: () => _selectDate(context, true),
                          ),
                          sizedBox,
                          ListTile(
                            title: const Text('End Date'),
                            subtitle: Text(
                              _endDate != null
                                  ? _endDate!.toLocal().toString().split(' ')[0]
                                  : 'Select a date',
                            ),
                            onTap: () => _selectDate(context, false),
                          ),
                          sizedBox,
                          DropdownButtonFormField<String>(
                            decoration: const InputDecoration(
                              labelText: 'Transportation',
                            ),
                            value: _transportation,
                            items: _transportationOptions
                                .map((transport) => DropdownMenuItem(
                                    value: transport, child: Text(transport)))
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                _transportation = value;
                              });
                            },
                            validator: (value) => value == null
                                ? 'Please select your transportation'
                                : null,
                          ),
                          sizedBox,
                          CheckboxListTile(
                            title: const Text('Accommodation Booked'),
                            value: _accommodation,
                            onChanged: (value) {
                              setState(() {
                                _accommodation = value!;
                              });
                            },
                          ),
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
