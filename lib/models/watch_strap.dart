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
  String _brand;
  String _model;
  StrapMaterial _material;
  Diameter _diameter;
  String _watchStrapImageUrl;

  WatchStrap(
      {required String brand,
      required String model,
      required StrapMaterial material,
      required Diameter diameter,
      required String watchStrapImageUrl,
      required super.name,
      required super.description,
      required super.price,
      required super.status,
      }): _brand = brand, 
          _model = model, 
          _material = material, 
          _diameter = diameter, 
          _watchStrapImageUrl = watchStrapImageUrl;
  
  String get brand => _brand;
  String get model => _model;
  StrapMaterial get material => _material;
  Diameter get diameter => _diameter;
  String get watchStrapImageUrl => _watchStrapImageUrl; 
  set brand(String brand) => _brand = brand;
  set model(String model) => _model = model;
  set material(StrapMaterial material) => _material = material;
  set diameter(Diameter diameter) => _diameter = diameter;
  set watchStrapImageUrl(String watchStrapImageUrl) => _watchStrapImageUrl = watchStrapImageUrl;
}
