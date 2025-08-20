class ServiceModel {
  final int id;
  final String name;
  final String description;
  final double price;
  final int companyId;

  ServiceModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.companyId,
  });

  factory ServiceModel.fromJson(Map<String, dynamic> j) => ServiceModel(
    id: j['id'] as int,
    name: j['name'] as String,
    description: j['description'] as String,
    price: (j['price'] as num).toDouble(),
    companyId: j['companyId'] as int,
  );
}
