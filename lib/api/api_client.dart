import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

String _baseUrl() {
  if (kIsWeb) return 'http://localhost:4000';
  try {
    if (Platform.isAndroid) return 'http://10.0.2.2:4000'; // Android emulator
  } catch (_) {}
  return 'http://localhost:4000'; // Windows/iOS/Chrome
}

class ApiClient {
  final http.Client _client = http.Client();
  final String base = _baseUrl();

  Future<List<dynamic>> getCompanies() async {
    final res = await _client.get(Uri.parse('$base/companies'));
    if (res.statusCode >= 400) throw Exception('Failed to load companies');
    return jsonDecode(res.body) as List<dynamic>;
  }

  Future<Map<String, dynamic>> createCompany(String name, String reg) async {
    final res = await _client.post(
      Uri.parse('$base/companies'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'name': name, 'registrationNumber': reg}),
    );
    if (res.statusCode >= 400) throw Exception('Failed to create company');
    return jsonDecode(res.body) as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> createService(
    String name,
    String desc,
    double price,
    int companyId,
  ) async {
    final res = await _client.post(
      Uri.parse('$base/services'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'name': name,
        'description': desc,
        'price': price,
        'companyId': companyId,
      }),
    );
    if (res.statusCode >= 400) throw Exception('Failed to create service');
    return jsonDecode(res.body) as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> getServiceById(int id) async {
    final res = await _client.get(Uri.parse('$base/services/$id'));
    if (res.statusCode == 404) throw Exception('Service not found');
    if (res.statusCode >= 400) throw Exception('Failed to get service');
    return jsonDecode(res.body) as Map<String, dynamic>;
  }
}
