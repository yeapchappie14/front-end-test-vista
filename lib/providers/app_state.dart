import 'package:flutter/material.dart';
import '../api/api_client.dart';
import '../models/company.dart';

class AppState extends ChangeNotifier {
  final _api = ApiClient();

  bool loading = false;
  String? error;
  List<CompanyModel> companies = [];

  Future<void> fetchCompanies() async {
    loading = true;
    error = null;
    notifyListeners();
    try {
      final list = await _api.getCompanies();
      companies = list
          .map((e) => CompanyModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      error = e.toString();
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  Future<bool> createCompany(String name, String reg) async {
    try {
      await _api.createCompany(name, reg);
      await fetchCompanies();
      return true;
    } catch (e) {
      error = e.toString();
      notifyListeners();
      return false;
    }
  }

  Future<bool> createService(
    String name,
    String desc,
    double price,
    int companyId,
  ) async {
    try {
      await _api.createService(name, desc, price, companyId);
      await fetchCompanies();
      return true;
    } catch (e) {
      error = e.toString();
      notifyListeners();
      return false;
    }
  }
}
