import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:watches_project/models/cart_item.dart';
import 'package:watches_project/providers/cart_provider.dart';

class CartItemWidget extends StatelessWidget {
  final CartItem cartItem;

  const CartItemWidget({super.key, required this.cartItem});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context, listen: false);

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: ListTile(
        leading: const Icon(Icons.shopping_bag),
        title: Text(cartItem.title),
        subtitle: Text('Price: \$${cartItem.price} x ${cartItem.quantity}'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: () => cart.removeItem(cartItem.id),
              icon: const Icon(Icons.remove_circle, color: Colors.red),
            ),
            IconButton(
              onPressed: () => cart.addItem(cartItem.id, cartItem.title, cartItem.price),
              icon: const Icon(Icons.add_circle, color: Colors.green),
            ),
          ],
        ),
      ),
    );
  }
}
