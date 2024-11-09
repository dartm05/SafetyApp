import 'package:flutter/material.dart';
import '../../../data/models/trip.dart';
import '../usecases/trip_list_usecases.dart';

class TripListProvider extends ChangeNotifier {
  final TripListUseCases tripListUseCases;
  List<Trip> _tripsList = <Trip>[];
  List<Trip> get tripsList => _tripsList;
  bool isLoading = false;

  TripListProvider({required this.tripListUseCases});

  Future<List<Trip>?> fetchTrips(String userId) async {
    isLoading = true;
    await tripListUseCases.fetchTrips(userId).then((value) {
      _tripsList = value ?? [];
      isLoading = false;
    }).catchError((error) {
      isLoading = false;
    }).whenComplete(() {
      isLoading = false;
    });
    notifyListeners();
    return _tripsList;
  }

  Future<void> deleteTrip(String userId, String tripId) async {
    isLoading = true;
    await tripListUseCases.deleteTrip(userId, tripId).then((value) {
      _tripsList.removeWhere((element) => element.id == tripId);
      isLoading = false;
    }).catchError((error) {
      isLoading = false;
    }).whenComplete(() {
      isLoading = false;
    });
    notifyListeners();
  }
}
