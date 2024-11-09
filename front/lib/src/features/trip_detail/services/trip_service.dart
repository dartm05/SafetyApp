import 'dart:convert';
import 'package:safety_app/src/core/providers/error_provider.dart';
import 'package:safety_app/src/core/services/http_service.dart';

import '../../../core/models/modal_model.dart';
import '../../../data/models/trip.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class TripService {
  final ErrorProvider errorProvider;
  final HttpService httpService;
  final String baseUrlPlaces =
      'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=';
  final String api_key = dotenv.env['PLACES_API_KEY'] ?? '';

  TripService({
    required this.errorProvider,
    required this.httpService,
  });

  Future<List<String>> fetchPlaces(String place) async {
    final response = await http.get(
      Uri.parse(
        '$baseUrlPlaces$place&key=$api_key',
      ),
    );

    if (response.statusCode == 200) {
      final predictions = json.decode(response.body)['predictions'];
      return List<String>.from(
          predictions.map((prediction) => prediction['description']));
    } else {
      throw Exception('Failed to load suggestions');
    }
  }

  Future<List<String>> fetchTripPlaces(String place) async {
    final response = await http.get(
      Uri.parse(
        '$baseUrlPlaces$place&type=lodging&key=$api_key',
      ),
    );
    if (response.statusCode == 200) {
      final predictions = json.decode(response.body)['predictions'];
      return List<String>.from(
          predictions.map((prediction) => prediction['description']));
    } else {
      throw Exception('Failed to load suggestions');
    }
  }

  Future<Trip?> getTrip(String userId, String tripId) async {
    try {
      var response = await httpService.get('/$userId/trips/$tripId');
      return Trip.fromJson(jsonDecode(response.body));
    } catch (error) {
      errorProvider.showError(
        error: Modal(
          title: 'Error',
          message: 'An error occurred while fetching trip. Please try again.',
          actionText: 'Close',
          action: () {
            errorProvider.hideError();
          },
        ),
      );
      return null;
    }
  }

  Future<Trip?> createTrip(String userId, Trip trip) async {
    try {
      var response =
          await httpService.post('/$userId/trips', body: trip.toJson());
      if (response.statusCode == 200) {
        return Trip.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to create trip');
      }
    } catch (error) {
      errorProvider.showError(
        error: Modal(
          title: 'Error',
          message: 'An error occurred while creating trip. Please try again.',
          actionText: 'Close',
          action: () {
            errorProvider.hideError();
          },
        ),
      );
    }
    return null;
  }

  Future<Trip?> updateTrip(String userId, String tripId, Trip trip) async {
    try {
      var response =
          await httpService.put('/$userId/trips/$tripId', body: trip.toJson());

      if (response.statusCode > 300) {
        throw Exception('Failed to update trip');
      }
      errorProvider.showError(
        error: Modal(
          title: 'Success',
          message: 'Trip updated successfully',
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
          message: 'An error occurred while updating trip. Please try again.',
          actionText: 'Close',
          action: () {
            errorProvider.hideError();
          },
        ),
      );
    }
    return null;
  }
}
