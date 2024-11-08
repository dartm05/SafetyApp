import 'dart:convert';
import 'package:safety_app/src/core/providers/error_provider.dart';

import '../models/trip.dart';
import 'package:http/http.dart' as http;

class TripService {
  final ErrorProvider errorProvider;

  TripService({required this.errorProvider});

  Future<List<String>> fetchPlaces(String place) async {
    final response = await http.get(
      Uri.parse(
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=${place}&key=AIzaSyBGzIzmMiVwWqVr7-dK6-4dzxWZgZOS7Z8',
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
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=${place}&type=lodging&key=AIzaSyBGzIzmMiVwWqVr7-dK6-4dzxWZgZOS7Z8',
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

  Future<void> createTrip(Trip trip) async {
    // Create a new trip
  }

  Future<void> updateTrip(Trip trip) async {
    // Update an existing trip
  }

  Future<void> deleteTrip(Trip trip) async {
    // Delete a trip
  }
}
