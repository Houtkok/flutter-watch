import 'package:watches_project/models/user.dart';

List<User> dummyUser = [
  User(
      name: 'Admin User',
      email: 'admin@gmail.com',
      password: '123123',
      address: ['Admin Address'],
      role: Role.admin,
    ),
  User(
      name: 'Buyer User',
      email: 'buyer@gmail.com',
      password: '123123',
      address: ['Buyer Address'],
      role: Role.buyer,
    ),
];