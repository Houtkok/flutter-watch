import 'package:flutter/material.dart';
import 'package:watches_project/models/product_manager.dart';
import 'package:watches_project/screens/user/account_screen.dart';
import 'package:watches_project/screens/user/cart_screen.dart';
import 'package:watches_project/screens/user/home_screen.dart';

class Navigationbar extends StatefulWidget {
  const Navigationbar({super.key, required this.productManager});
  final ProductManager productManager;

  @override
  State<Navigationbar> createState() => _NavigationbarState();
}

class _NavigationbarState extends State<Navigationbar> {
  int _selectedIndex = 0;

  late List<Widget> _widgetOptions;

  @override
  void initState() {
    super.initState();
    _widgetOptions = <Widget>[
      HomeScreen(productManager: widget.productManager),
      const CartScreen(),
      const AccountScreen()
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Account',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        unselectedItemColor: const Color.fromARGB(255, 135, 115, 99),
        selectedIconTheme: IconThemeData(color: Colors.amber[800]),
        unselectedIconTheme:
            const IconThemeData(color: Color.fromARGB(255, 135, 115, 99)),
        onTap: _onItemTapped,
      ),
    );
  }
}
