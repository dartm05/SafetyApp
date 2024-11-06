import 'package:flutter/material.dart';

import '../services/trip_service.dart';

class TripFormProvider extends ChangeNotifier {
  final _formKey = GlobalKey<FormState>();
  var _placesList = <String>[];
  final TripService _tripService;

  TripFormProvider({required TripService tripService})
      : _tripService = tripService;

  GlobalKey<FormState> get formKey => _formKey;

  List<String> get placesList => _placesList;

  void submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
    }
  }

  Future<void> fetchPlaces(String place) async {
    if (place.isEmpty) {
      _placesList = [];
      notifyListeners();
      return;
    }
    placesList.clear();
    final places = await _tripService.fetchPlaces(place);
    _placesList.addAll(places);
    notifyListeners();
  }

  void clearPlacesList() {
    _placesList =[];
    notifyListeners();
  }
}
