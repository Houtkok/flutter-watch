import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final String brand;
  final String model;
  final String price;

  const ProductCard({
    super.key,
    required this.brand,
    required this.model,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              color: Colors.grey[300],
              child: Center(
                child: Image.network(
                  'https://wallpapershome.com/animals/birds/bird-colorful-flowers-25630.html',
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => const Icon(Icons.image_not_supported,
                    size: 100, color: Colors.grey),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(brand,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 24)),
                Text(model, style: const TextStyle(fontSize: 18)),
                Text('\$$price', style: const TextStyle(fontSize: 18)),
                const SizedBox(
                  height: 8,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
