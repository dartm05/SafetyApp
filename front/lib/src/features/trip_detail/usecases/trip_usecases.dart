import '../../../core/providers/auth_provider.dart';
import '../../../data/models/trip.dart';
import '../services/trip_service.dart';

class TripUseCases {
  final TripService tripService;
  final AuthenticationProvider authenticationProvider;

  TripUseCases(
      {required this.tripService, required this.authenticationProvider});

  Future<List<String>> fetchPlaces(String place) async {
    return await tripService.fetchPlaces(place);
  }

  Future<Trip?> getTrip(String userId, String tripId) async {
    return await tripService.getTrip(userId, tripId);
  }

  Future<Trip?> createTrip(Trip trip) async {
    return await tripService.createTrip(authenticationProvider.userId!, trip);
  }

  Future<Trip?> updateTrip(Trip trip) async {
    return await tripService.updateTrip(authenticationProvider.userId!, trip);
  }
}
