import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:safety_app/src/data/models/trip.dart';

import '../providers/trip_form_provider.dart';

class TripPlacesScreen extends StatefulWidget {
  const TripPlacesScreen({super.key});

  @override
  State<TripPlacesScreen> createState() => _TripPlacesScreenState();
}

class _TripPlacesScreenState extends State<TripPlacesScreen> {
  final _formKey = GlobalKey<FormState>();

  String? _selectedTravelStyle;
  bool _ladiesOnlyMetro = false;
  bool _ladiesOnlyTaxi = false;
  bool _loudNoiseSensitivity = false;
  bool _crowdFear = false;
  bool _noIsolatedPlace = false;
  bool _lowCrime = false;
  bool _publicTransportationOnly = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final tripFormProvider = Provider.of<TripFormProvider>(context);
    if (tripFormProvider.selectedTrip != null) {
      final trip = tripFormProvider.selectedTrip!;
      _selectedTravelStyle = trip.travelStyle;
      _ladiesOnlyMetro = trip.ladiesOnlyMetro;
      _ladiesOnlyTaxi = trip.ladiesOnlyTaxi;
      _loudNoiseSensitivity = trip.loudNoiseSensitive;
      _crowdFear = trip.crowdFear;
      _noIsolatedPlace = trip.noIsolatedPlaces;
      _lowCrime = trip.lowCrime;
      _publicTransportationOnly = trip.publicTransportOnly;
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    SizedBox sizedBoxM = width > 800 ? SizedBox(height: 60,) : SizedBox(height: 20);
    final tripFormProvider = Provider.of<TripFormProvider>(context);
    return ListView(
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
          child: SizedBox(
            width: width > 800 ? 600 : width,
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
                                  .fetchTripPlaces(textEditingValue.text);
                              return tripFormProvider.placesList;
                            },
                            initialValue: TextEditingValue(
                              text: tripFormProvider.selectedTrip?.hotel ?? '',
                            ),
                            onSelected: (String selection) {
                              setState(() {
                                tripFormProvider.setHotel(selection);
                              });
                            },
                            fieldViewBuilder: (BuildContext context,
                                TextEditingController textEditingController,
                                FocusNode focusNode,
                                VoidCallback onFieldSubmitted) {
                              return TextFormField(
                                controller: textEditingController,
                                focusNode: focusNode,
                                decoration: const InputDecoration(
                                  labelText: 'Hotel',
                                ),
                                validator: (value) =>
                                    value == null || value.isEmpty
                                        ? 'Please enter where you are staying'
                                        : null,
                              );
                            },
                          ),
                          sizedBoxM,
                          DropdownButtonFormField<String>(
                            value: _selectedTravelStyle,
                            decoration: const InputDecoration(
                              labelText: 'Travel Style',
                            ),
                            items: <String>['Business', 'Leisure', 'Adventure']
                                .map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                _selectedTravelStyle = newValue;
                              });
                            },
                            validator: (value) => value == null || value.isEmpty
                                ? 'Please select a travel style'
                                : null,
                          ),
                          sizedBoxM,
                          CheckboxListTile(
                            title: const Text('Ladies only metro service'),
                            value: _ladiesOnlyMetro,
                            onChanged: (bool? value) {
                              setState(() {
                                _ladiesOnlyMetro = value ?? false;
                              });
                            },
                          ),
                          CheckboxListTile(
                            title: const Text('Ladies only taxi services'),
                            value: _ladiesOnlyTaxi,
                            onChanged: (bool? value) {
                              setState(() {
                                _ladiesOnlyTaxi = value ?? false;
                              });
                            },
                          ),
                          CheckboxListTile(
                            title: const Text('Loud noise sensitivity'),
                            value: _loudNoiseSensitivity,
                            onChanged: (bool? value) {
                              setState(() {
                                _loudNoiseSensitivity = value ?? false;
                              });
                            },
                          ),
                          CheckboxListTile(
                            title: const Text('Crowd fear'),
                            value: _crowdFear,
                            onChanged: (bool? value) {
                              setState(() {
                                _crowdFear = value ?? false;
                              });
                            },
                          ),
                          CheckboxListTile(
                            title: const Text('No isolated place'),
                            value: _noIsolatedPlace,
                            onChanged: (bool? value) {
                              setState(() {
                                _noIsolatedPlace = value ?? false;
                              });
                            },
                          ),
                          CheckboxListTile(
                            title: const Text('Low crime'),
                            value: _lowCrime,
                            onChanged: (bool? value) {
                              setState(() {
                                _lowCrime = value ?? false;
                              });
                            },
                          ),
                          CheckboxListTile(
                            title: const Text('Public transportation only'),
                            value: _publicTransportationOnly,
                            onChanged: (bool? value) {
                              setState(() {
                                _publicTransportationOnly = value ?? false;
                              });
                            },
                          ),
                          sizedBoxM,
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 5.0, horizontal: 20),
                            child: ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  Trip newTrip = Trip(
                                    origin: tripFormProvider.origin,
                                    destination: tripFormProvider.destination,
                                    startDate: tripFormProvider.startDate,
                                    endDate: tripFormProvider.endDate,
                                    transportation:
                                        tripFormProvider.transportation,
                                    hotel: tripFormProvider.hotel,
                                    travelStyle: _selectedTravelStyle!,
                                    ladiesOnlyMetro: _ladiesOnlyMetro,
                                    ladiesOnlyTaxi: _ladiesOnlyTaxi,
                                    loudNoiseSensitive: _loudNoiseSensitivity,
                                    crowdFear: _crowdFear,
                                    noIsolatedPlaces: _noIsolatedPlace,
                                    lowCrime: _lowCrime,
                                    publicTransportOnly:
                                        _publicTransportationOnly,
                                  );
                                  if (tripFormProvider.selectedTrip != null) {
                                    newTrip.id =
                                        tripFormProvider.selectedTrip!.id;
                                    tripFormProvider.updateTrip(newTrip).then(
                                      (value) {
                                        context.go('/trip_list');
                                      },
                                    );
                                  } else {
                                    tripFormProvider
                                        .createTrip(newTrip)
                                        .then((value) {
                                      context.go('/trip_list');
                                    });
                                  }
                                }
                              },
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
        ),
      ],
    );
  }
}
