import 'package:uuid/uuid.dart';

class Product {
  final String _productID;
  String _name;
  String _description;
  double _price;
  bool _status;
  bool _onTrend;
  String _imageUrl;

  String get imageUrl => _imageUrl;
  set imageUrl(String value) => _imageUrl = value;

  Product({
    required String name,
    required String description,
    required double price,
    required bool status,
    required bool onTrend,
    required String imageUrl
  })  : _productID = const Uuid().v4(),
        _name = name,
        _description = description,
        _price = price,
        _status = status,
        _onTrend = onTrend == false,
        _imageUrl = imageUrl;

  String get productID => _productID;
  String get name => _name;
  String get description => _description;
  double get price => _price;
  bool get status => _status;
  bool get onTrend => _onTrend;

  set name(String value) => _name = value;
  set description(String value) => _description = value;
  set price(double value) => _price = value;
  set status(bool value) => _status = value;
  set onTrend(bool value) => _onTrend = value;

}
