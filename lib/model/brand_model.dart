class BrandModel {
  late String brand;
  late List<String> vehicles;

  BrandModel({required this.brand, required this.vehicles});

  @override
  String toString() {
    return 'BrandModel{brand: $brand, vehicles: $vehicles}';
  }
}
