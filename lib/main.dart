import 'package:flutter/material.dart' ;
import 'package:provider/provider.dart';
import 'package:watches_project/data/dummy_products.dart';
import 'package:watches_project/data/dummy_user.dart';
import 'package:watches_project/models/product_manager.dart';
import 'package:watches_project/models/user.dart';
import 'package:watches_project/models/user_manager.dart';
import 'package:watches_project/providers/cart_provider.dart';
import 'package:watches_project/screens/user/address_screen.dart';
import 'package:watches_project/screens/user/login.dart';
import 'package:watches_project/screens/user/navigation_bar.dart';

class WatchApp extends StatelessWidget {
  WatchApp({super.key});
  final userManager = UserManager();
  final ProductManager productManager = ProductManager();
  final adminUser = dummyUser.firstWhere((user) => user.role == Role.admin);

  @override
  Widget build(BuildContext context) {
    for(var user in dummyUser){
      userManager.addUser(user.name, user.email, user.password, user.address, user.role);
    }
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ProductManager>(
          create: (_){
            final productManager = ProductManager();
            for(var product in dummyProducts){
              productManager.addProduct(adminUser, product);
            }
            return productManager;
          },
          ),
          Provider<UserManager>(
            create: (_) => userManager,
          ),
          ChangeNotifierProvider(create: (_) => CartProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,

        initialRoute: '/login',
        routes: {
          '/address' : (context) => Consumer<UserManager>(
            builder: (_, userManager, __){
              final loggedInUser = userManager.loggedInUser;
                if (loggedInUser != null) {
                  return AddressScreen(user: loggedInUser);
                } else {
                  return Login(userManager: userManager);
                }
            },
          ),
          '/home': (context) => Consumer<ProductManager>(
            builder: (_, productManager, __) => Navigationbar(productManager: productManager),
          ),
          '/login': (context) => Login(userManager: userManager),
        },
      ),
      );
  }
}
void main(){
  runApp(WatchApp());
}