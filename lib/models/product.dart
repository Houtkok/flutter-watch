import 'package:uuid/uuid.dart';

class Product {
  final String _productID;
  String _name;
  String _description;
  double _price;
  bool _status;

  Product({
    required String name,
    required String description,
    required double price,
    required bool status,
  })  : _productID = const Uuid().v4(),
        _name = name,
        _description = description,
        _price = price,
        _status = status;

  String get productID => _productID;
  String get name => _name;
  String get description => _description;
  double get price => _price;
  bool get status => _status;

  set name(String value) => _name = value;
  set description(String value) => _description = value;
  set price(double value) => _price = value;
  set status(bool value) => _status = value;

}
