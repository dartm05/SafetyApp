import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HttpService {
  final String baseUrl;

  HttpService({required this.baseUrl});

  Future<http.Response> get(String endpoint,
      {required Map<String, dynamic> body}) async {
    final response = await http.get(Uri.parse('$baseUrl$endpoint'));
    return response;
  }

  Future<http.Response> post(String endpoint,
      {required Map<String, dynamic> body}) async {
    final response = await http.post(
      Uri.parse('$baseUrl$endpoint'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );
    return response;
  }
}

class HttpServiceProvider with ChangeNotifier {
  final HttpService httpService;

  HttpServiceProvider({required this.httpService});

  Future<http.Response> get(String endpoint,
      {required Map<String, dynamic> body}) async {
    return await httpService.get(endpoint, body: body);
  }

  Future<http.Response> post(String endpoint,
      {required Map<String, dynamic> body}) async {
    return await httpService.post(endpoint, body: body);
  }
}