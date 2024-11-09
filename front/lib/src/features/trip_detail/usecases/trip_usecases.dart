
import '../models/trip.dart';
import '../services/trip_service.dart';

class TripUseCases {
 final TripService tripService;

  TripUseCases({required this.tripService});

  Future<List<String>> fetchPlaces(String place) async {
    return await tripService.fetchPlaces(place);
  }

  Future<List<String>> fetchTripPlaces(String place) async {
    return await tripService.fetchTripPlaces(place);
  }

  Future<Trip?> getTrip(String userId, String tripId) async {
    return await tripService.getTrip(userId, tripId);
  }

  Future<Trip?> createTrip(String userId, Trip trip) async {
    return await tripService.createTrip(userId, trip);
  }

  Future<Trip?> updateTrip(String userId, String tripId, Trip trip) async {
    return await tripService.updateTrip(userId, tripId, trip);
  }

}