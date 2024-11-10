import 'package:flutter/material.dart';
import 'package:safety_app/src/data/models/trip.dart';
import '../usecases/trip_usecases.dart';

class TripFormProvider extends ChangeNotifier {
  String? _destination;
  String? _origin;
  DateTime? _startDate;
  DateTime? _endDate;
  String? _transportation;

  var _placesList = <String>[];
  get origin => _origin;
  get destination => _destination;
  get startDate => _startDate;
  get endDate => _endDate;
  get transportation => _transportation;
  final TripUseCases _tripUseCases;

  TripFormProvider({required TripUseCases tripUseCases})
      : _tripUseCases = tripUseCases;

  List<String> get placesList => _placesList;

  Future<void> fetchPlaces(String place) async {
    if (place.isEmpty) {
      _placesList = [];
      notifyListeners();
      return;
    }
    placesList.clear();
    final places = await _tripUseCases.fetchPlaces(place);
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
    final places = await _tripUseCases.fetchTripPlaces(place);
    _placesList.addAll(places);
    notifyListeners();
  }

  void clearPlacesList() {
    _placesList = [];
    notifyListeners();
  }

  void setDestination(String destination) {
    _destination = destination;
    notifyListeners();
  }

  void setOrigin(String origin) {
    _origin = origin;
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

  Future<void> createTrip(Trip trip) async {
    await _tripUseCases.createTrip(trip);
  }
}
