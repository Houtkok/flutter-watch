import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:watches_project/models/product.dart';
import 'package:watches_project/models/watch.dart';
import 'package:watches_project/models/watch_strap.dart';
import 'package:watches_project/providers/cart_provider.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key, required this.product});
  final Product product;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int _quantity = 1;

  void _incrementQuantity() {
    setState(() {
      _quantity++;
    });
  }

  void _decrementQuantity() {
    if (_quantity > 1) {
      setState(() {
        _quantity--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);

    final product = widget.product;
    final isWatch = product is Watch;
    final isStrap = product is WatchStrap;

    final brand = isWatch? (product).brand.displayNames : isStrap ? (product).brand : 'Unknown';
    final model = isWatch ? product.model : isStrap ? product.model : 'Unknown';
    final movement = isWatch ? product.movement.displayName : null;

    return Scaffold(
      appBar: AppBar(
        title: Text('$brand $model'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildImageSection(),
            const SizedBox(height: 20),
            _buildProductInfoSection(brand, model, movement),
            const SizedBox(height: 10),
            if (isStrap) _buildStrapDetails(product),
            const Spacer(),
            _buildQuantitySelector(),
            _buildAddToCartButton(cartProvider, brand, model),
          ],
        ),
      ),
    );
  }

  Widget _buildImageSection() {
    return Expanded(
      child: Container(
        height: 250,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(15),
        ),
        child: Image.network(
          'https://www.scientificamerican.com/article/we-are-in-the-golden-age-of-bird-watching/',
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => const Icon(Icons.image_not_supported,
              size: 100, color: Colors.grey),
        ),
      ),
    );
  }

  Widget _buildProductInfoSection(
      String brand, String model, String? movement) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.product.name,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 5),
        Text(
          '\$${widget.product.price.toStringAsFixed(2)}',
          style: const TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey),
        ),
        const SizedBox(height: 10),
        Text('Brand: $brand', style: const TextStyle(fontSize: 18)),
        Text('Model: $model', style: const TextStyle(fontSize: 18)),
        if (movement != null)
          Text('Movement: $movement', style: const TextStyle(fontSize: 18)),
        const SizedBox(height: 10),
        Text(
          'Description: ${widget.product.description}',
          style: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }

  Widget _buildStrapDetails(WatchStrap strap) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Material: ${strap.material}',
            style: const TextStyle(fontSize: 16)),
        Text('Diameter: ${strap.diameter}',
            style: const TextStyle(fontSize: 16)),
      ],
    );
  }

  Widget _buildQuantitySelector() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: _decrementQuantity,
          icon: const Icon(Icons.remove),
          tooltip: 'Decrease quantity',
        ),
        Text(
          _quantity.toString(),
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        IconButton(
          onPressed: _incrementQuantity,
          icon: const Icon(Icons.add),
          tooltip: 'Increase quantity',
        ),
      ],
    );
  }

  Widget _buildAddToCartButton(
      CartProvider cartProvider, String brand, String model) {
    return SizedBox(
      height: 60,
      child: ElevatedButton(
        onPressed: () {
          cartProvider.addItem(
            widget.product.productID,
            widget.product.name,
            widget.product.price.toInt(),
            _quantity,
          );
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content:
                Text('${widget.product.name} added to the cart (x$_quantity)'),
            duration: const Duration(seconds: 2),
          ));
          Navigator.pop(context);
        },
        child: const Text('Add to Cart', style: TextStyle(fontSize: 18)),
      ),
    );
  }
}
