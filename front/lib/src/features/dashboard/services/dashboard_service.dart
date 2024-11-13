import 'dart:convert';

import 'package:safety_app/src/core/models/modal_model.dart';

import 'package:safety_app/src/core/providers/error_provider.dart';
import 'package:safety_app/src/core/services/http_service.dart';
import 'package:safety_app/src/data/models/dashboard.dart';
import 'package:safety_app/src/data/models/error.model.dart';

class DashboardService {
  final HttpService _httpService;
  final ErrorProvider _errorProvider;

  DashboardService({
    required HttpService httpService,
    required ErrorProvider errorProvider,
  })  : _httpService = httpService,
        _errorProvider = errorProvider;

  Future<Dashboard?> getDashboard(String userId) async {
    final response = await _httpService.get(
      '/$userId/dashboard',
    );
    if (response.statusCode == 500) {
      throw Exception('Error fetching dashboard');
    }
    if (response.statusCode == 404) {
      Error error = Error.fromJson(jsonDecode(response as String));
      _errorProvider.showError(
        error: Modal(
          title: error.title,
          message: error.message,
          actionText: 'Close',
          action: () {
            _errorProvider.hideError();
          },
        ),
      );
      return null;
    }
    return Dashboard.fromMap(jsonDecode(response.body));
  }

  Future<void> createDashboard(String userId) async {
    final response = await _httpService.post(
      '/$userId/dashboard',
      body: {},
    );
    if (response.statusCode == 500) {
      throw Exception('Error creating dashboard');
    }

    if (response.statusCode == 404) {
      Error error = Error.fromJson(jsonDecode(response as String));
      _errorProvider.showError(
        error: Modal(
          title: error.title,
          message: error.message,
          actionText: 'Close',
          action: () {
            _errorProvider.hideError();
          },
        ),
      );
    }
  }
}
