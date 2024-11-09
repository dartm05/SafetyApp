import 'dart:convert';

import 'package:safety_app/src/core/models/modal_model.dart';
import 'package:safety_app/src/core/providers/error_provider.dart';
import 'package:safety_app/src/core/services/http_service.dart';

import '../../trip_detail/models/trip.dart';

class TripListService {
  final ErrorProvider errorProvider;
  final HttpService httpService;

  TripListService({
    required this.errorProvider,
    required this.httpService,
  });

  Future<List<Trip>?> fetchTrips(String userId) async {
    try {
      var response = await httpService.get('/users/$userId/trips');
      if (response.statusCode > 300) {
        throw Exception('Failed to fetch trips');
      }
      var trips = List<Map<String, dynamic>>.from(jsonDecode(response.body));
      return trips.map((trip) => Trip.fromJson(trip)).toList();
    } catch (error) {
      errorProvider.showError(
        error: Modal(
          title: 'Error',
          message: 'An error occurred while fetching trips. Please try again.',
          actionText: 'Close',
          action: () {
            errorProvider.hideError();
          },
        ),
      );
    }
    return [];
  }

  Future<void> deleteTrip(String userId, String tripId) async {
    try {
      var response = await httpService.delete('/trips/$tripId');
      if (response.statusCode > 300) {
        throw Exception('Failed to delete trip');
      }
      errorProvider.showError(
        error: Modal(
          title: 'Success',
          message: 'Trip deleted successfully',
          actionText: 'Close',
          action: () {
            errorProvider.hideError();
          },
        ),
      );
    } catch (error) {
      errorProvider.showError(
        error: Modal(
          title: 'Error',
          message: 'An error occurred while deleting trip. Please try again.',
          actionText: 'Close',
          action: () {
            errorProvider.hideError();
          },
        ),
      );
    }
  }
}
