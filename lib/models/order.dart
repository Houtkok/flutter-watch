// import 'package:uuid/uuid.dart';

// class Order {
//   final String _orderID;
//   final String _productID;
//   final String _buyerID;
//   final DateTime _orderDate;
//   String _shippingAddress;

//   Order({
//     required String productID,
//     required String buyerID,
//     required DateTime orderDate,
//     required String shippingAddress,
//   })  : _orderID = const Uuid().v4(),
//         _productID = productID,
//         _buyerID = buyerID,
//         _orderDate = orderDate,
//         _shippingAddress = shippingAddress;

//   String get orderID => _orderID;
//   String get productID => _productID;
//   String get buyerID => _buyerID;
//   DateTime get orderDate => _orderDate;
//   String get shippingAddress => _shippingAddress;

//   set shippingAddress(String value) => _shippingAddress = value;

//   void createOrder() {}

//   void viewOrder() {}
// }
