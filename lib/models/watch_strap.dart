import 'package:watches_project/models/product.dart';

enum StrapMaterial {
  canvas('Canvas'),
  exotic('Exotic'),
  leather('Leather'),
  rubber('Rubber'),
  steel('Steel'),
  parachute('Parachute'),
  titanium('Titanium');

  final String displayName;
  const StrapMaterial(this.displayName);

  static List<String> get displayStrapMaterials =>
      StrapMaterial.values.map((e) => e.displayName).toList();
}
enum Diameter {
  d38('38'),
  d40('40'),
  d42('42'),
  d44('44');

  final String displayName;
  const Diameter(this.displayName);

  static List<String> get displayDiameters =>
      Diameter.values.map((e) => e.displayName).toList();
}

class WatchStrap extends Product {
  String brand;
  String model;
  StrapMaterial material;
  Diameter diameter;

  WatchStrap(
      {required this.brand,
      required this.model,
      required this.material,
      required this.diameter,
      required super.name,
      required super.description,
      required super.price,
      required super.status,
      required super.onTrend});
}
