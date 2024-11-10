import 'package:safety_app/src/core/providers/auth_provider.dart';
import 'package:safety_app/src/features/trip_list/services/trip_list_service.dart';

import '../../../data/models/trip.dart';

class TripListUseCases {
  final TripListService tripListService;
  final AuthenticationProvider authenticationProvider;

  TripListUseCases(
      {required this.tripListService, required this.authenticationProvider});

  Future<List<Trip>?> fetchTrips() async {
    return await tripListService.fetchTrips(authenticationProvider.userId!);
  }

  Future<Trip?> deleteTrip(String tripId) async {
    return await tripListService.deleteTrip(
        authenticationProvider.userId!, tripId);
  }
}
