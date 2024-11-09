import 'package:safety_app/src/features/trip_list/services/trip_list_service.dart';

import '../../trip_detail/models/trip.dart';

class TripListUseCases {
  final TripListService tripListService;

  TripListUseCases({required this.tripListService});

  Future<List<Trip>?> fetchTrips(String userId) async {
    return await tripListService.fetchTrips(userId);
  }

  Future<void> deleteTrip(String userId, String tripId) async {
    return await tripListService.deleteTrip(userId, tripId);
  }
}
