import 'service.dart';

class CompanyModel {
  final int id;
  final String name;
  final String registrationNumber;
  final List<ServiceModel> services;

  CompanyModel({
    required this.id,
    required this.name,
    required this.registrationNumber,
    required this.services,
  });

  factory CompanyModel.fromJson(Map<String, dynamic> j) => CompanyModel(
    id: j['id'] as int,
    name: j['name'] as String,
    registrationNumber: j['registrationNumber'] as String,
    services: (j['services'] as List<dynamic>? ?? [])
        .map((e) => ServiceModel.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}
