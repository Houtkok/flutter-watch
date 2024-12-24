import 'package:flutter/material.dart';
import 'package:watches_project/providers/cart_provider.dart';
import 'package:provider/provider.dart';
import 'package:watches_project/widgets/app_bar.dart';
import 'package:watches_project/widgets/cart_item.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  void _confirmClearCart(BuildContext context, CartProvider cart) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Clear Cart'),
        content: const Text('Are you sure you want to clear your cart?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              cart.clearCart();
              Navigator.of(ctx).pop();
            },
            child: const Text('Clear'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: buildAppBar('Your Cart'),
      body: cart.itemCount == 0
          ? const Center(
              child: Text(
                'Your cart is empty.',
                style: TextStyle(fontSize: 20),
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cart.itemCount,
                    itemBuilder: (ctx, index) {
                      final cartItem = cart.items.values.toList()[index];
                      return CartItemWidget(cartItem: cartItem);
                    },
                  ),
                ),
                const Divider(),
                _buildCartSummary(cart, context),
              ],
            ),
    );
  }

  Widget _buildCartSummary(CartProvider cart, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total: \$${cart.totalAmount.toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              ElevatedButton(
                onPressed: () {
                  cart.clearCart();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Checkout successful!')),
                  );
                },
                child: const Text('Checkout'),
              ),
            ],
          ),
          const SizedBox(height: 10),
          TextButton(
            onPressed: () => _confirmClearCart(context, cart),
            child: const Text(
              'Clear Cart',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}

