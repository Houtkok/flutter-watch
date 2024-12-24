import 'package:uuid/uuid.dart';

class Product {
  final String _productID;
  String _name;
  String _description;
  double _price;
  bool _status;
  bool _onTrend;

  Product({
    required String name,
    required String description,
    required double price,
    required bool status,
    required bool onTrend,
  })  : _productID = const Uuid().v4(),
        _name = name,
        _description = description,
        _price = price,
        _status = status,
        _onTrend = onTrend == false;

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

  // void viewDetails() {
  //   print('Product ID: $_productID');
  //   print('Name: $_name');
  //   print('Description: $_description');
  //   print('Price: \$_$_price');
  //   print('Status: ${_status ? "Available" : "Unavailable"}');
  //   print('Trending: $_onTrend');
  // }

  // void updateDetails(
  //     {String? name, String? description, double? price, bool? status}) {
  //   if (name != null) _name = name;
  //   if (description != null) _description = description;
  //   if (price != null) _price = price;
  //   if (status != null) _status = status;
  //   print('Product $_name updated successfully.');
  // }
}
