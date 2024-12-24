import 'package:uuid/uuid.dart';
import 'package:validators/validators.dart';

enum Role { buyer, admin }

class User {
  final String _userID;
  String _name;
  String _email;
  String _password;
  final List<String> _address;
  final Role _role;

  User({
    required String name,
    required String email,
    required String password,
    required List<String> address,
    required Role role,
  })  : _userID = const Uuid().v4(),
        _name = name,
        _email = email,
        _password = password,
        _address = address,
        _role = role;

  String get userID => _userID;
  String get name => _name;
  String get email => _email;
  List<String> get address => _address;
  Role get role => _role;
  String get password => _password;

  set name(String value){
    if(value.isEmpty){
      throw Exception("Name cannot be empty");
    }
    _name =  value;
  }

  set email(String value){
    if(!isEmail(value)){
      throw Exception("Invalid Email");
    }
    else{
      _email = value;
    }
  }

  void addAddress(String value){
    if(value.isEmpty){
      throw Exception("Address cannot be empty");
    }
    _address.add(value);
  }

  void editAddress(int index, String newValue){
    if(index < 0 || index >= _address.length){
      throw Exception("Invalid input");
    }
    if(newValue.isEmpty){
      throw Exception("Address cannot be empty");
    }
    _address[index] = newValue;
  }

  void deleteAddress(int index){
    if(index<0 || index >= address.length){
      throw Exception("invalid index");
    }
    address.removeAt(index);
  }

  set password(String value){
    if(value.isEmpty){
      throw Exception("Password cannot be empty");
    }
    _password = value;
  }
}
