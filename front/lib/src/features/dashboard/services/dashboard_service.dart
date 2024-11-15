import 'dart:convert';

import 'package:safety_app/src/data/models/modal_model.dart';

import 'package:safety_app/src/core/providers/error_provider.dart';
import 'package:safety_app/src/core/services/http_service.dart';
import 'package:safety_app/src/data/models/dashboard.dart';
import 'package:safety_app/src/data/models/error.dart';

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
    if (response.statusCode == 204 ||
        response.headers['content-length'] == '0') {
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
      final Map<String, dynamic> errorResponse = jsonDecode(response.body);
      Error error = Error(
        title: errorResponse['title'],
        message: errorResponse['message'],
        statusCode: errorResponse['statusCode'],
        status: errorResponse['status'],
      );
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

  Future<void> deleteDashboard(String userId, String dashboardId) async {
    final response = await _httpService.delete(
      '/$userId/dashboard/$dashboardId',
    );
   if (response.statusCode == 404 || response.statusCode == 500) {
      final Map<String, dynamic> errorResponse = jsonDecode(response.body);
      Error error = Error(
        title: errorResponse['title'],
        message: errorResponse['message'],
        statusCode: errorResponse['statusCode'],
        status: errorResponse['status'],
      );
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
