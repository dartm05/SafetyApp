import 'package:flutter/material.dart';

import '../services/trip_service.dart';

class TripFormProvider extends ChangeNotifier {
  String? destination;
  String? _origin;
  DateTime? _startDate;
  DateTime? _endDate;
  String? _transportation;
  var _placesList = <String>[];
  final TripService _tripService;

  TripFormProvider({required TripService tripService})
      : _tripService = tripService;

  List<String> get placesList => _placesList;

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

  Future<void> fetchTripPlaces(String place) async {
    if (place.isEmpty) {
      _placesList = [];
      notifyListeners();
      return;
    }
    placesList.clear();
    final places = await _tripService.fetchTripPlaces(place);
    _placesList.addAll(places);
    notifyListeners();
  }

  void clearPlacesList() {
    _placesList = [];
    notifyListeners();
  }

  void setDestination(String destination) {
    destination = destination;
    notifyListeners();
  }

  void setOrigin(String origin) {
    _origin = origin;
    print(_origin);
    notifyListeners();
  }

  void setStartDate(DateTime startDate) {
    _startDate = startDate;
    notifyListeners();
  }

  void setEndDate(DateTime endDate) {
    _endDate = endDate;
    notifyListeners();
  }

  void setTransportation(String transportation) {
    _transportation = transportation;
    notifyListeners();
  }

  void submitForm() {
    if (destination != null &&
        _origin != null &&
        _startDate != null &&
        _endDate != null &&
        _transportation != null) {
 /*      _tripService.saveTrip(
        destination: _destination!,
        origin: _origin!,
        startDate: _startDate!,
        endDate: _endDate!,
        transportation: _transportation!,
      ); */
    }
  }
}
