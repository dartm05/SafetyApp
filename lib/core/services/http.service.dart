import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HttpService {
  final String baseUrl;

  HttpService({required this.baseUrl});

  Future<http.Response> get(String endpoint) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl$endpoint'));
      _handleResponse(response);
      return response;
    } catch (e) {
      throw Exception('Failed to get data: $e');
    }
  }

  Future<http.Response> post(String endpoint, {required Map<String, dynamic> body}) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl$endpoint'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );
      _handleResponse(response);
      return response;
    } catch (e) {
      throw Exception('Failed to post data: $e');
    }
  }

  void _handleResponse(http.Response response) {
    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception('Error: ${response.statusCode} ${response.reasonPhrase}');
    }
  }
}

class HttpServiceProvider with ChangeNotifier {
  final HttpService httpService;

  HttpServiceProvider({required this.httpService});

  Future<http.Response> get(String endpoint) async {
    return await httpService.get(endpoint);
  }

  Future<http.Response> post(String endpoint, {required Map<String, dynamic> body}) async {
    return await httpService.post(endpoint, body: body);
  }
}