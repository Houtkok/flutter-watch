import 'package:watches_project/models/user.dart';

class UserManager {
  final List<User> _users = [];
  User? _loggedInUser;
  
  List<User> get allUser => _users;
  User? get loggedInUser => _loggedInUser;

  void addUser(String name, String email, String password, List<String> address, Role role){
    if(_users.any((user) => user.email == email)){
      throw Exception('User with this email already have');
    }
    _users.add(
      User(
        name: name,
        email: email, 
        password: password, 
        address: address, 
        role: role)
    );
  }

  User? authenticate(String email, String password){
    try {
      final user = _users.firstWhere(
        (user) => user.email == email && user.password == password,
      );
      _loggedInUser = user; 
      return user;
    } on Exception {
      return null;
    }
  }

  void logout(){
    _loggedInUser = null;
  }
}