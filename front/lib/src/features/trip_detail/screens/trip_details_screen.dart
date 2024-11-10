import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:safety_app/src/features/trip_detail/providers/trip_form_provider.dart';
import 'package:provider/provider.dart';

class TripDetailsPage extends StatefulWidget {
  const TripDetailsPage({super.key});

  @override
  State<TripDetailsPage> createState() => _TripDetailsPageState();
}

class _TripDetailsPageState extends State<TripDetailsPage> {
  final _formKey = GlobalKey<FormState>();

  DateTime? _startDate;
  DateTime? _endDate;
  String? _transportation;

  final List<String> _transportationOptions = [
    'Car',
    'Plane',
    'Train',
    'Bus',
    'Other'
  ];

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    final tripFormProvider =
        Provider.of<TripFormProvider>(context, listen: false);
    if (picked != null && picked != (isStartDate ? _startDate : _endDate)) {
      if (isStartDate) {
        setState(() {
          _startDate = picked;
        });
        tripFormProvider.setStartDate(picked);
      } else {
        if (_startDate != null && picked.isBefore(_startDate!)) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('End date cannot be before start date'),
            ),
          );
        } else {
          setState(() {
            _endDate = picked;
          });
          tripFormProvider.setEndDate(picked);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    const sizedBox = SizedBox(height: 40);
    const sizedBoxM = SizedBox(height: 20);
    final tripFormProvider = Provider.of<TripFormProvider>(context);

    return Column(
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
          child: ListView(
            shrinkWrap: true,
            children: [
              Padding(
                padding:
                    const EdgeInsets.only(top: 24.0, left: 20.0, right: 20.0),
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
                            tripFormProvider.setOrigin(selection);
                          },
                          fieldViewBuilder: (BuildContext context,
                              TextEditingController textEditingController,
                              FocusNode focusNode,
                              VoidCallback onFieldSubmitted) {
                            return TextFormField(
                              controller: textEditingController,
                              focusNode: focusNode,
                              decoration: const InputDecoration(
                                labelText: 'Origin',
                              ),
                              validator: (value) =>
                                  value == null || value.isEmpty
                                      ? 'Please enter your origin'
                                      : null,
                            );
                          },
                        ),
                        sizedBoxM,
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
                            tripFormProvider.setDestination(selection);
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
                                ? _startDate!.toLocal().toString().split(' ')[0]
                                : 'Select a date',
                          ),
                          onTap: () => _selectDate(context, true),
                        ),
                        sizedBoxM,
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
                            tripFormProvider.setTransportation(value!);
                          },
                          validator: (value) => value == null
                              ? 'Please select your transportation'
                              : null,
                        ),
                        sizedBox,
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 16.0, horizontal: 20),
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                context.push('/trip_detail/trip_detail_next');
                              }
                            },
                            child: const Text('Next'),
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
    );
  }
}
